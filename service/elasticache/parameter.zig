const ChangeType = @import("change_type.zig").ChangeType;

/// Describes an individual setting that controls some aspect of ElastiCache
/// behavior.
pub const Parameter = struct {
    /// The valid range of values for the parameter.
    allowed_values: ?[]const u8 = null,

    /// Indicates whether a change to the parameter is applied immediately or
    /// requires a
    /// reboot for the change to be applied. You can force a reboot or wait until
    /// the next
    /// maintenance window's reboot. For more information, see [Rebooting a
    /// Cluster](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/Clusters.Rebooting.html).
    change_type: ?ChangeType = null,

    /// The valid data type for the parameter.
    data_type: ?[]const u8 = null,

    /// A description of the parameter.
    description: ?[]const u8 = null,

    /// Indicates whether (`true`) or not (`false`) the parameter can be
    /// modified. Some parameters have security or operational implications that
    /// prevent them
    /// from being changed.
    is_modifiable: ?bool = null,

    /// The earliest cache engine version to which the parameter can apply.
    minimum_engine_version: ?[]const u8 = null,

    /// The name of the parameter.
    parameter_name: ?[]const u8 = null,

    /// The value of the parameter.
    parameter_value: ?[]const u8 = null,

    /// The source of the parameter.
    source: ?[]const u8 = null,
};
