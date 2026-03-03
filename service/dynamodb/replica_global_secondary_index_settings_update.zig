const AutoScalingSettingsUpdate = @import("auto_scaling_settings_update.zig").AutoScalingSettingsUpdate;

/// Represents the settings of a global secondary index for a global table that
/// will be
/// modified.
pub const ReplicaGlobalSecondaryIndexSettingsUpdate = struct {
    /// The name of the global secondary index. The name must be unique among all
    /// other
    /// indexes on this table.
    index_name: []const u8,

    /// Auto scaling settings for managing a global secondary index replica's read
    /// capacity
    /// units.
    provisioned_read_capacity_auto_scaling_settings_update: ?AutoScalingSettingsUpdate = null,

    /// The maximum number of strongly consistent reads consumed per second before
    /// DynamoDB
    /// returns a `ThrottlingException`.
    provisioned_read_capacity_units: ?i64 = null,

    pub const json_field_names = .{
        .index_name = "IndexName",
        .provisioned_read_capacity_auto_scaling_settings_update = "ProvisionedReadCapacityAutoScalingSettingsUpdate",
        .provisioned_read_capacity_units = "ProvisionedReadCapacityUnits",
    };
};
