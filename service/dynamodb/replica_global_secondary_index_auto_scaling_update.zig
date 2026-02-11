const AutoScalingSettingsUpdate = @import("auto_scaling_settings_update.zig").AutoScalingSettingsUpdate;

/// Represents the auto scaling settings of a global secondary index for a
/// replica that
/// will be modified.
pub const ReplicaGlobalSecondaryIndexAutoScalingUpdate = struct {
    /// The name of the global secondary index.
    index_name: ?[]const u8,

    provisioned_read_capacity_auto_scaling_update: ?AutoScalingSettingsUpdate,

    pub const json_field_names = .{
        .index_name = "IndexName",
        .provisioned_read_capacity_auto_scaling_update = "ProvisionedReadCapacityAutoScalingUpdate",
    };
};
