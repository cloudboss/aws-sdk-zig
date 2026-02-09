const ReplicaGlobalSecondaryIndexSettingsUpdate = @import("replica_global_secondary_index_settings_update.zig").ReplicaGlobalSecondaryIndexSettingsUpdate;
const AutoScalingSettingsUpdate = @import("auto_scaling_settings_update.zig").AutoScalingSettingsUpdate;
const TableClass = @import("table_class.zig").TableClass;

/// Represents the settings for a global table in a Region that will be
/// modified.
pub const ReplicaSettingsUpdate = struct {
    /// The Region of the replica to be added.
    region_name: []const u8,

    /// Represents the settings of a global secondary index for a global table that
    /// will be
    /// modified.
    replica_global_secondary_index_settings_update: ?[]const ReplicaGlobalSecondaryIndexSettingsUpdate,

    /// Auto scaling settings for managing a global table replica's read capacity
    /// units.
    replica_provisioned_read_capacity_auto_scaling_settings_update: ?AutoScalingSettingsUpdate,

    /// The maximum number of strongly consistent reads consumed per second before
    /// DynamoDB
    /// returns a `ThrottlingException`. For more information, see [Specifying Read
    /// and Write
    /// Requirements](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#ProvisionedThroughput) in the *Amazon DynamoDB
    /// Developer Guide*.
    replica_provisioned_read_capacity_units: ?i64,

    /// Replica-specific table class. If not specified, uses the source table's
    /// table
    /// class.
    replica_table_class: ?TableClass,
};
