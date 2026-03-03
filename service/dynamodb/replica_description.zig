const ReplicaGlobalSecondaryIndexDescription = @import("replica_global_secondary_index_description.zig").ReplicaGlobalSecondaryIndexDescription;
const GlobalTableSettingsReplicationMode = @import("global_table_settings_replication_mode.zig").GlobalTableSettingsReplicationMode;
const OnDemandThroughputOverride = @import("on_demand_throughput_override.zig").OnDemandThroughputOverride;
const ProvisionedThroughputOverride = @import("provisioned_throughput_override.zig").ProvisionedThroughputOverride;
const ReplicaStatus = @import("replica_status.zig").ReplicaStatus;
const TableClassSummary = @import("table_class_summary.zig").TableClassSummary;
const TableWarmThroughputDescription = @import("table_warm_throughput_description.zig").TableWarmThroughputDescription;

/// Contains the details of the replica.
pub const ReplicaDescription = struct {
    /// Replica-specific global secondary index settings.
    global_secondary_indexes: ?[]const ReplicaGlobalSecondaryIndexDescription = null,

    /// Indicates one of the settings synchronization modes for the global table
    /// replica:
    ///
    /// * `ENABLED`: Indicates that the settings synchronization mode for the global
    ///   table
    /// replica is enabled.
    ///
    /// * `DISABLED`: Indicates that the settings synchronization mode for the
    ///   global table
    /// replica is disabled.
    ///
    /// * `ENABLED_WITH_OVERRIDES`: This mode is set by default for a same account
    ///   global table.
    /// Indicates that certain global table settings can be overridden.
    global_table_settings_replication_mode: ?GlobalTableSettingsReplicationMode = null,

    /// The KMS key of the replica that will be used for KMS
    /// encryption.
    kms_master_key_id: ?[]const u8 = null,

    /// Overrides the maximum on-demand throughput settings for the specified
    /// replica
    /// table.
    on_demand_throughput_override: ?OnDemandThroughputOverride = null,

    /// Replica-specific provisioned throughput. If not described, uses the source
    /// table's
    /// provisioned throughput settings.
    provisioned_throughput_override: ?ProvisionedThroughputOverride = null,

    /// The name of the Region.
    region_name: ?[]const u8 = null,

    /// The time at which the replica was first detected as inaccessible. To
    /// determine cause
    /// of inaccessibility check the `ReplicaStatus` property.
    replica_inaccessible_date_time: ?i64 = null,

    /// The current state of the replica:
    ///
    /// * `CREATING` - The replica is being created.
    ///
    /// * `UPDATING` - The replica is being updated.
    ///
    /// * `DELETING` - The replica is being deleted.
    ///
    /// * `ACTIVE` - The replica is ready for use.
    ///
    /// * `REGION_DISABLED` - The replica is inaccessible because the Amazon Web
    ///   Services Region has been disabled.
    ///
    /// If the Amazon Web Services Region remains inaccessible for more than 20
    /// hours, DynamoDB will remove this replica from the replication
    /// group. The replica will not be deleted and replication will stop from and to
    /// this region.
    ///
    /// * `INACCESSIBLE_ENCRYPTION_CREDENTIALS ` - The KMS key
    /// used to encrypt the table is inaccessible.
    ///
    /// If the KMS key remains inaccessible for more than 20 hours,
    /// DynamoDB will remove this replica from the replication group.
    /// The replica will not be deleted and replication will stop from and to this
    /// region.
    replica_status: ?ReplicaStatus = null,

    /// Detailed information about the replica status.
    replica_status_description: ?[]const u8 = null,

    /// Specifies the progress of a Create, Update, or Delete action on the replica
    /// as a
    /// percentage.
    replica_status_percent_progress: ?[]const u8 = null,

    replica_table_class_summary: ?TableClassSummary = null,

    /// Represents the warm throughput value for this replica.
    warm_throughput: ?TableWarmThroughputDescription = null,

    pub const json_field_names = .{
        .global_secondary_indexes = "GlobalSecondaryIndexes",
        .global_table_settings_replication_mode = "GlobalTableSettingsReplicationMode",
        .kms_master_key_id = "KMSMasterKeyId",
        .on_demand_throughput_override = "OnDemandThroughputOverride",
        .provisioned_throughput_override = "ProvisionedThroughputOverride",
        .region_name = "RegionName",
        .replica_inaccessible_date_time = "ReplicaInaccessibleDateTime",
        .replica_status = "ReplicaStatus",
        .replica_status_description = "ReplicaStatusDescription",
        .replica_status_percent_progress = "ReplicaStatusPercentProgress",
        .replica_table_class_summary = "ReplicaTableClassSummary",
        .warm_throughput = "WarmThroughput",
    };
};
