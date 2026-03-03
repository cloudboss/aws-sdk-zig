const BillingModeSummary = @import("billing_mode_summary.zig").BillingModeSummary;
const ReplicaGlobalSecondaryIndexSettingsDescription = @import("replica_global_secondary_index_settings_description.zig").ReplicaGlobalSecondaryIndexSettingsDescription;
const AutoScalingSettingsDescription = @import("auto_scaling_settings_description.zig").AutoScalingSettingsDescription;
const ReplicaStatus = @import("replica_status.zig").ReplicaStatus;
const TableClassSummary = @import("table_class_summary.zig").TableClassSummary;

/// Represents the properties of a replica.
pub const ReplicaSettingsDescription = struct {
    /// The Region name of the replica.
    region_name: []const u8,

    /// The read/write capacity mode of the replica.
    replica_billing_mode_summary: ?BillingModeSummary = null,

    /// Replica global secondary index settings for the global table.
    replica_global_secondary_index_settings: ?[]const ReplicaGlobalSecondaryIndexSettingsDescription = null,

    /// Auto scaling settings for a global table replica's read capacity units.
    replica_provisioned_read_capacity_auto_scaling_settings: ?AutoScalingSettingsDescription = null,

    /// The maximum number of strongly consistent reads consumed per second before
    /// DynamoDB
    /// returns a `ThrottlingException`. For more information, see [Specifying Read
    /// and Write
    /// Requirements](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#ProvisionedThroughput) in the *Amazon DynamoDB
    /// Developer Guide*.
    replica_provisioned_read_capacity_units: ?i64 = null,

    /// Auto scaling settings for a global table replica's write capacity units.
    replica_provisioned_write_capacity_auto_scaling_settings: ?AutoScalingSettingsDescription = null,

    /// The maximum number of writes consumed per second before DynamoDB returns a
    /// `ThrottlingException`. For more information, see [Specifying Read and Write
    /// Requirements](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#ProvisionedThroughput) in the *Amazon DynamoDB
    /// Developer Guide*.
    replica_provisioned_write_capacity_units: ?i64 = null,

    /// The current state of the Region:
    ///
    /// * `CREATING` - The Region is being created.
    ///
    /// * `UPDATING` - The Region is being updated.
    ///
    /// * `DELETING` - The Region is being deleted.
    ///
    /// * `ACTIVE` - The Region is ready for use.
    replica_status: ?ReplicaStatus = null,

    replica_table_class_summary: ?TableClassSummary = null,

    pub const json_field_names = .{
        .region_name = "RegionName",
        .replica_billing_mode_summary = "ReplicaBillingModeSummary",
        .replica_global_secondary_index_settings = "ReplicaGlobalSecondaryIndexSettings",
        .replica_provisioned_read_capacity_auto_scaling_settings = "ReplicaProvisionedReadCapacityAutoScalingSettings",
        .replica_provisioned_read_capacity_units = "ReplicaProvisionedReadCapacityUnits",
        .replica_provisioned_write_capacity_auto_scaling_settings = "ReplicaProvisionedWriteCapacityAutoScalingSettings",
        .replica_provisioned_write_capacity_units = "ReplicaProvisionedWriteCapacityUnits",
        .replica_status = "ReplicaStatus",
        .replica_table_class_summary = "ReplicaTableClassSummary",
    };
};
