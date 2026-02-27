const AwsDynamoDbTableKeySchema = @import("aws_dynamo_db_table_key_schema.zig").AwsDynamoDbTableKeySchema;
const AwsDynamoDbTableProjection = @import("aws_dynamo_db_table_projection.zig").AwsDynamoDbTableProjection;
const AwsDynamoDbTableProvisionedThroughput = @import("aws_dynamo_db_table_provisioned_throughput.zig").AwsDynamoDbTableProvisionedThroughput;

/// Information abut a global secondary index for the table.
pub const AwsDynamoDbTableGlobalSecondaryIndex = struct {
    /// Whether the index is currently backfilling.
    backfilling: ?bool,

    /// The ARN of the index.
    index_arn: ?[]const u8,

    /// The name of the index.
    index_name: ?[]const u8,

    /// The total size in bytes of the index.
    index_size_bytes: ?i64,

    /// The current status of the index.
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATING`
    ///
    /// * `DELETING`
    ///
    /// * `UPDATING`
    index_status: ?[]const u8,

    /// The number of items in the index.
    item_count: ?i32,

    /// The key schema for the index.
    key_schema: ?[]const AwsDynamoDbTableKeySchema,

    /// Attributes that are copied from the table into an index.
    projection: ?AwsDynamoDbTableProjection,

    /// Information about the provisioned throughput settings for the indexes.
    provisioned_throughput: ?AwsDynamoDbTableProvisionedThroughput,

    pub const json_field_names = .{
        .backfilling = "Backfilling",
        .index_arn = "IndexArn",
        .index_name = "IndexName",
        .index_size_bytes = "IndexSizeBytes",
        .index_status = "IndexStatus",
        .item_count = "ItemCount",
        .key_schema = "KeySchema",
        .projection = "Projection",
        .provisioned_throughput = "ProvisionedThroughput",
    };
};
