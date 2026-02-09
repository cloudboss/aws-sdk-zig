const AutoScalingSettingsUpdate = @import("auto_scaling_settings_update.zig").AutoScalingSettingsUpdate;

/// Represents the auto scaling settings of a global secondary index for a
/// global table
/// that will be modified.
pub const GlobalSecondaryIndexAutoScalingUpdate = struct {
    /// The name of the global secondary index.
    index_name: ?[]const u8,

    provisioned_write_capacity_auto_scaling_update: ?AutoScalingSettingsUpdate,
};
