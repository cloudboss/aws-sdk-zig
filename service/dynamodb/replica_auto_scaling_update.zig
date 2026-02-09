const ReplicaGlobalSecondaryIndexAutoScalingUpdate = @import("replica_global_secondary_index_auto_scaling_update.zig").ReplicaGlobalSecondaryIndexAutoScalingUpdate;
const AutoScalingSettingsUpdate = @import("auto_scaling_settings_update.zig").AutoScalingSettingsUpdate;

/// Represents the auto scaling settings of a replica that will be modified.
pub const ReplicaAutoScalingUpdate = struct {
    /// The Region where the replica exists.
    region_name: []const u8,

    /// Represents the auto scaling settings of global secondary indexes that will
    /// be
    /// modified.
    replica_global_secondary_index_updates: ?[]const ReplicaGlobalSecondaryIndexAutoScalingUpdate,

    replica_provisioned_read_capacity_auto_scaling_update: ?AutoScalingSettingsUpdate,
};
