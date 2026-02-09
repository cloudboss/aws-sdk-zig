const IndexStatus = @import("index_status.zig").IndexStatus;
const AutoScalingSettingsDescription = @import("auto_scaling_settings_description.zig").AutoScalingSettingsDescription;

/// Represents the properties of a global secondary index.
pub const ReplicaGlobalSecondaryIndexSettingsDescription = struct {
    /// The name of the global secondary index. The name must be unique among all
    /// other
    /// indexes on this table.
    index_name: []const u8,

    /// The current status of the global secondary index:
    ///
    /// * `CREATING` - The global secondary index is being created.
    ///
    /// * `UPDATING` - The global secondary index is being updated.
    ///
    /// * `DELETING` - The global secondary index is being deleted.
    ///
    /// * `ACTIVE` - The global secondary index is ready for use.
    index_status: ?IndexStatus,

    /// Auto scaling settings for a global secondary index replica's read capacity
    /// units.
    provisioned_read_capacity_auto_scaling_settings: ?AutoScalingSettingsDescription,

    /// The maximum number of strongly consistent reads consumed per second before
    /// DynamoDB
    /// returns a `ThrottlingException`.
    provisioned_read_capacity_units: ?i64,

    /// Auto scaling settings for a global secondary index replica's write capacity
    /// units.
    provisioned_write_capacity_auto_scaling_settings: ?AutoScalingSettingsDescription,

    /// The maximum number of writes consumed per second before DynamoDB returns a
    /// `ThrottlingException`.
    provisioned_write_capacity_units: ?i64,
};
