const AwsDynamoDbTableProvisionedThroughputOverride = @import("aws_dynamo_db_table_provisioned_throughput_override.zig").AwsDynamoDbTableProvisionedThroughputOverride;

/// Information about a global secondary index for a DynamoDB table replica.
pub const AwsDynamoDbTableReplicaGlobalSecondaryIndex = struct {
    /// The name of the index.
    index_name: ?[]const u8,

    /// Replica-specific configuration for the provisioned throughput for the index.
    provisioned_throughput_override: ?AwsDynamoDbTableProvisionedThroughputOverride,

    pub const json_field_names = .{
        .index_name = "IndexName",
        .provisioned_throughput_override = "ProvisionedThroughputOverride",
    };
};
