const AwsDynamoDbTableReplicaGlobalSecondaryIndex = @import("aws_dynamo_db_table_replica_global_secondary_index.zig").AwsDynamoDbTableReplicaGlobalSecondaryIndex;
const AwsDynamoDbTableProvisionedThroughputOverride = @import("aws_dynamo_db_table_provisioned_throughput_override.zig").AwsDynamoDbTableProvisionedThroughputOverride;

/// Information about a replica of a DynamoDB table.
pub const AwsDynamoDbTableReplica = struct {
    /// List of global secondary indexes for the replica.
    global_secondary_indexes: ?[]const AwsDynamoDbTableReplicaGlobalSecondaryIndex,

    /// The identifier of the KMS key that will be used for KMS
    /// encryption for the replica.
    kms_master_key_id: ?[]const u8,

    /// Replica-specific configuration for the provisioned throughput.
    provisioned_throughput_override: ?AwsDynamoDbTableProvisionedThroughputOverride,

    /// The name of the Region where the replica is located.
    region_name: ?[]const u8,

    /// The current status of the replica. Valid values are as follows:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATING`
    ///
    /// * `CREATION_FAILED`
    ///
    /// * `DELETING`
    ///
    /// * `UPDATING`
    replica_status: ?[]const u8,

    /// Detailed information about the replica status.
    replica_status_description: ?[]const u8,

    pub const json_field_names = .{
        .global_secondary_indexes = "GlobalSecondaryIndexes",
        .kms_master_key_id = "KmsMasterKeyId",
        .provisioned_throughput_override = "ProvisionedThroughputOverride",
        .region_name = "RegionName",
        .replica_status = "ReplicaStatus",
        .replica_status_description = "ReplicaStatusDescription",
    };
};
