const ReplicaGlobalSecondaryIndexAutoScalingDescription = @import("replica_global_secondary_index_auto_scaling_description.zig").ReplicaGlobalSecondaryIndexAutoScalingDescription;
const AutoScalingSettingsDescription = @import("auto_scaling_settings_description.zig").AutoScalingSettingsDescription;
const ReplicaStatus = @import("replica_status.zig").ReplicaStatus;

/// Represents the auto scaling settings of the replica.
pub const ReplicaAutoScalingDescription = struct {
    /// Replica-specific global secondary index auto scaling settings.
    global_secondary_indexes: ?[]const ReplicaGlobalSecondaryIndexAutoScalingDescription,

    /// The Region where the replica exists.
    region_name: ?[]const u8,

    replica_provisioned_read_capacity_auto_scaling_settings: ?AutoScalingSettingsDescription,

    replica_provisioned_write_capacity_auto_scaling_settings: ?AutoScalingSettingsDescription,

    /// The current state of the replica:
    ///
    /// * `CREATING` - The replica is being created.
    ///
    /// * `UPDATING` - The replica is being updated.
    ///
    /// * `DELETING` - The replica is being deleted.
    ///
    /// * `ACTIVE` - The replica is ready for use.
    replica_status: ?ReplicaStatus,
};
