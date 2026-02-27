const CacheNodeTypeSpecificParameter = @import("cache_node_type_specific_parameter.zig").CacheNodeTypeSpecificParameter;
const Parameter = @import("parameter.zig").Parameter;

/// Represents the output of a `DescribeEngineDefaultParameters`
/// operation.
pub const EngineDefaults = struct {
    /// A list of parameters specific to a particular cache node type. Each element
    /// in the
    /// list contains detailed information about one parameter.
    cache_node_type_specific_parameters: ?[]const CacheNodeTypeSpecificParameter,

    /// Specifies the name of the cache parameter group family to which the engine
    /// default
    /// parameters apply.
    ///
    /// Valid values are: `memcached1.4` | `memcached1.5` |
    /// `memcached1.6` | `redis2.6` | `redis2.8` |
    /// `redis3.2` | `redis4.0` | `redis5.0` |
    /// `redis6.0` | `redis6.x` | `redis7`
    cache_parameter_group_family: ?[]const u8,

    /// Provides an identifier to allow retrieval of paginated results.
    marker: ?[]const u8,

    /// Contains a list of engine default parameters.
    parameters: ?[]const Parameter,
};
