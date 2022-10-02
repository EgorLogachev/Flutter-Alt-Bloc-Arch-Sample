import 'dart:async';

import 'package:flutter/foundation.dart';

        typedef Creator<T extends Object> = FutureOr<T> Function(DependenciesProvider dp);

abstract class DependenciesRegistrar {
    factory DependenciesRegistrar() => _DependenciesManager();

    /// This method responsible for registration of dependency with specific type.
    /// [creator] - function that encapsulates the process of dependency creation.
    /// [tag] - optional argument that should be used in case you wanna register a few different dependencies of the same type.
    /// [lazy] - argument that defines when dependency will be created. If `true` it creates during first obtain() call, otherwise dependency will be created immediately during registration. Default `true`.
    /// [weak] - argument that defines dependency release strategy. If `true` dependency will be collected by garbage collector, as soon as all references to this dependency will be released, otherwise dependency lives in memory until [DependenciesRegistrar] exist in memory or [dispose] method will be called. Default `true`.
    /// PAY ATTENTION! If your [Creator] function returns [Future], so you have to use [obtainAsync] method to obtain dependency and [obtain] otherwise.
    void register<T extends Object>(
    Creator<T> creator, {
        dynamic tag,
        bool lazy = true,
        bool weak = true,
    });

    DependenciesProvider get provider;
    int get registeredInstancesNumber;
    int get createdInstancesNumber;
    void dispose();
}

abstract class DependenciesProvider {
    /// This method returns dependency of a specified type.
    /// [tag] -  this argument should be defined if several dependencies of the same type was registered before.
    T obtain<T extends Object>({dynamic tag});

    /// This method returns Future with dependency of a specified type. PAY ATTENTION!!! This method have to be used if your [Creator] function returns [Future].
    /// [tag] -  this argument should be defined if several dependencies of the same type was registered before.
    Future<T> obtainAsync<T extends Object>({dynamic tag});
}

class _DependenciesManager implements DependenciesRegistrar, DependenciesProvider {
    final _factories = <Type, _DependencyFactory>{};
    final _dependencies = <Type, _Dependency>{};

    @override
    void register<T extends Object>(
    Creator<T> creator, {
        dynamic tag,
        bool lazy = true,
        bool weak = true,
    }) {
        _register<T>(creator, tag: tag, lazy: lazy, weak: weak);
        if (!lazy) _obtain<T>(tag: tag);
    }

    void _register<T extends Object>(
    Creator<T> creator, {
        dynamic tag,
        bool lazy = true,
        bool weak = true,
    }) {
        final factory = _factories[T];
        if (factory == null) {
            _factories[T] = _DependencyFactory<T>(creator, weak, tag);
        } else {
            factory.add(creator, weak, tag);
        }
    }

    /// This method get [Creator] from `_creatorsStorage` and creates dependency of a specified type.
    _Dependency<T> _createDependency<T extends Object>(dynamic tag) {
        final factory = _factories[T];
        if (factory == null) throw StateError('Type $T dependency can\'t be created. Check that you have registered it before.');
        return factory.create(this, tag: tag) as _Dependency<T>;
    }

    @override
    T obtain<T extends Object>({dynamic tag}) {
        return _obtain<T>(tag: tag) as T;
    }

    @override
    Future<T> obtainAsync<T extends Object>({tag}) {
        return _obtain<T>(tag: tag) as Future<T>;
    }

    FutureOr<T>? _obtain<T extends Object>({dynamic tag}) {
        if (!_dependencies.containsKey(T)) _dependencies[T] = _createDependency<T>(tag);
        final dependency = _dependencies[T] as _Dependency<T>;
        if (dependency.isEmpty(tag: tag)) dependency.update(_createDependency<T>(tag));
        return dependency.get(tag: tag);
    }

    @override
    void dispose() {
        _dependencies.clear();
        _factories.clear();
    }

    @override
    @visibleForTesting
    int get registeredInstancesNumber => _factories.length;

    @override
    @visibleForTesting
    int get createdInstancesNumber => _dependencies.length;

    @override
    DependenciesProvider get provider => this;
}

///Factories
abstract class _DependencyFactory<T extends Object> {
    factory _DependencyFactory(Creator<T> creator, bool weak, dynamic tag) =>
    tag == null ? _SingleDependencyFactory<T>(creator, weak) : _MultiDependencyFactory<T>(creator, weak, tag);

    _Dependency<T> create(DependenciesProvider dp, {dynamic tag});

    void add(Creator<T> creator, bool weak, dynamic tag);
}

class _SingleDependencyFactory<T extends Object> implements _DependencyFactory<T> {
    final Creator<T> _creator;
    final bool _weak;

    _SingleDependencyFactory(this._creator, this._weak);

    @override
    _Dependency<T> create(DependenciesProvider dp, {dynamic tag}) {
        assert(tag == null);
        final dependency = _creator.call(dp);
        return _weak ? _WeakDependency<T>(dependency) : _StrongDependency<T>(dependency);
    }

    @override
    void add(Creator<T> creator, bool weak, dynamic tag) {
        throw UnsupportedError(
                'Single instance `Creator` of such type $T has been already registered. Use `tag` argument for all registrations of the same type if you wanna register more than one instance.',);
    }
}

class _MultiDependencyFactory<T extends Object> implements _DependencyFactory<T> {
    _MultiDependencyFactory(Creator<T> creator, bool weak, dynamic tag) {
        add(creator, weak, tag);
    }

    final Map<dynamic, _DependencyFactory<T>> _creators = <dynamic, _DependencyFactory<T>>{};

    @override
    _Dependency<T> create(DependenciesProvider dp, {dynamic tag}) {
        if (tag == null) throw StateError('Provide `tag` argument to create dependency with type $T');
        if (!_creators.containsKey(tag)) throw StateError('The dependency cannot be created. Check that dependency with tag $tag has been registered before.');
        return _MultiDependency(_creators[tag]!.create(dp), tag);
    }

    @override
    void add(Creator<T> creator, bool weak, dynamic tag) {
        if (tag == null) throw StateError('You have already registered an instance of such type $T. Define `tag` argument to register two or more instance of the same type.');
        if (_creators.containsKey(tag)) throw StateError('You have already registered an instance of such type $T with tag $tag. Try to use some other tag to register this instance.');
        _creators[tag] = _SingleDependencyFactory(creator, weak);
    }
}

/// Dependency Container
abstract class _Dependency<T extends Object> {

    FutureOr<T>? get({dynamic tag});

    bool isEmpty({dynamic tag});

    void update(_Dependency<T> dependency);
}

class _MultiDependency<T extends Object> extends _Dependency<T> {
    _MultiDependency(_Dependency<T> value, dynamic tag) {
        _dependencies[tag] = value;
    }

    final Map<dynamic, _Dependency<T>> _dependencies = <dynamic, _Dependency<T>>{};

    @override
    FutureOr<T>? get({dynamic tag}) {
        if (tag == null) throw StateError('To obtain $T dependency `tag` argument needs to be provided.');
        return _dependencies[tag]!.get();
    }

    @override
    bool isEmpty({dynamic tag}) {
        if (tag == null) throw StateError('To obtain $T dependency `tag` argument needs to be provided.');
        return _dependencies[tag]?.isEmpty() ?? true;
    }

    @override
    void update(_Dependency<T> dependency) {
        assert(dependency is _MultiDependency);
        _dependencies.addAll((dependency as _MultiDependency<T>)._dependencies);
    }
}

class _WeakDependency<T extends Object> implements _Dependency<T> {

    WeakReference<FutureOr<T>> _value;

    _WeakDependency(FutureOr<T> value) : _value = WeakReference<FutureOr<T>>(value);

    @override
    FutureOr<T>? get({dynamic tag}) {
        assert(tag == null);
        return _value.target;
    }

    @override
    void update(_Dependency<T> dependency) {
        assert(dependency is _WeakDependency);
        _value = (dependency as _WeakDependency<T>)._value;
    }

    @override
    bool isEmpty({dynamic tag}) {
        assert(tag == null);
        return _value.target == null;
    }
}

class _StrongDependency<T extends Object> implements _Dependency<T> {

    final FutureOr<T> _value;

    _StrongDependency(this._value);

    @override
    FutureOr<T>? get({dynamic tag}) {
        assert(tag == null);
        return _value;
    }

    @override
    bool isEmpty({tag}) {
        assert(tag == null);
        return false;
    }

    @override
    void update(_Dependency<T> dependency) {
        assert(dependency is _StrongDependency);
        throw UnimplementedError();
    }
}
