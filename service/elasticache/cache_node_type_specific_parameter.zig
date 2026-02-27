const CacheNodeTypeSpecificValue = @import("cache_node_type_specific_value.zig").CacheNodeTypeSpecificValue;
const ChangeType = @import("change_type.zig").ChangeType;

/// A parameter that has a different value for each cache node type it is
/// applied to. For
/// example, in a Valkey or Redis OSS cluster, a `cache.m1.large` cache node
/// type would have a
/// larger `maxmemory` value than a `cache.m1.small` type.
pub const CacheNodeTypeSpecificParameter = struct {
    /// The valid range of values for the parameter.
    allowed_values: ?[]const u8,

    /// A list of cache node types and their corresponding values for this
    /// parameter.
    cache_node_type_specific_values: ?[]const CacheNodeTypeSpecificValue,

    /// Indicates whether a change to the parameter is applied immediately or
    /// requires a
    /// reboot for the change to be applied. You can force a reboot or wait until
    /// the next
    /// maintenance window's reboot. For more information, see [Rebooting a
    /// Cluster](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/Clusters.Rebooting.html).
    change_type: ?ChangeType,

    /// The valid data type for the parameter.
    data_type: ?[]const u8,

    /// A description of the parameter.
    description: ?[]const u8,

    /// Indicates whether (`true`) or not (`false`) the parameter can be
    /// modified. Some parameters have security or operational implications that
    /// prevent them
    /// from being changed.
    is_modifiable: ?bool,

    /// The earliest cache engine version to which the parameter can apply.
    minimum_engine_version: ?[]const u8,

    /// The name of the parameter.
    parameter_name: ?[]const u8,

    /// The source of the parameter value.
    source: ?[]const u8,
};
