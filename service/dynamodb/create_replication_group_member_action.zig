const ReplicaGlobalSecondaryIndex = @import("replica_global_secondary_index.zig").ReplicaGlobalSecondaryIndex;
const OnDemandThroughputOverride = @import("on_demand_throughput_override.zig").OnDemandThroughputOverride;
const ProvisionedThroughputOverride = @import("provisioned_throughput_override.zig").ProvisionedThroughputOverride;
const TableClass = @import("table_class.zig").TableClass;

/// Represents a replica to be created.
pub const CreateReplicationGroupMemberAction = struct {
    /// Replica-specific global secondary index settings.
    global_secondary_indexes: ?[]const ReplicaGlobalSecondaryIndex,

    /// The KMS key that should be used for KMS encryption in
    /// the new replica. To specify a key, use its key ID, Amazon Resource Name
    /// (ARN), alias
    /// name, or alias ARN. Note that you should only provide this parameter if the
    /// key is
    /// different from the default DynamoDB KMS key
    /// `alias/aws/dynamodb`.
    kms_master_key_id: ?[]const u8,

    /// The maximum on-demand throughput settings for the specified replica table
    /// being
    /// created. You can only modify `MaxReadRequestUnits`, because you can't modify
    /// `MaxWriteRequestUnits` for individual replica tables.
    on_demand_throughput_override: ?OnDemandThroughputOverride,

    /// Replica-specific provisioned throughput. If not specified, uses the source
    /// table's
    /// provisioned throughput settings.
    provisioned_throughput_override: ?ProvisionedThroughputOverride,

    /// The Region where the new replica will be created.
    region_name: []const u8,

    /// Replica-specific table class. If not specified, uses the source table's
    /// table
    /// class.
    table_class_override: ?TableClass,

    pub const json_field_names = .{
        .global_secondary_indexes = "GlobalSecondaryIndexes",
        .kms_master_key_id = "KMSMasterKeyId",
        .on_demand_throughput_override = "OnDemandThroughputOverride",
        .provisioned_throughput_override = "ProvisionedThroughputOverride",
        .region_name = "RegionName",
        .table_class_override = "TableClassOverride",
    };
};
