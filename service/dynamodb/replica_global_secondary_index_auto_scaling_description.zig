const IndexStatus = @import("index_status.zig").IndexStatus;
const AutoScalingSettingsDescription = @import("auto_scaling_settings_description.zig").AutoScalingSettingsDescription;

/// Represents the auto scaling configuration for a replica global secondary
/// index.
pub const ReplicaGlobalSecondaryIndexAutoScalingDescription = struct {
    /// The name of the global secondary index.
    index_name: ?[]const u8,

    /// The current state of the replica global secondary index:
    ///
    /// * `CREATING` - The index is being created.
    ///
    /// * `UPDATING` - The table/index configuration is being updated. The
    /// table/index remains available for data operations when
    /// `UPDATING`
    ///
    /// * `DELETING` - The index is being deleted.
    ///
    /// * `ACTIVE` - The index is ready for use.
    index_status: ?IndexStatus,

    provisioned_read_capacity_auto_scaling_settings: ?AutoScalingSettingsDescription,

    provisioned_write_capacity_auto_scaling_settings: ?AutoScalingSettingsDescription,
};
