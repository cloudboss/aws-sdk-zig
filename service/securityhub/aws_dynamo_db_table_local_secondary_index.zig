const AwsDynamoDbTableKeySchema = @import("aws_dynamo_db_table_key_schema.zig").AwsDynamoDbTableKeySchema;
const AwsDynamoDbTableProjection = @import("aws_dynamo_db_table_projection.zig").AwsDynamoDbTableProjection;

/// Information about a local secondary index for a DynamoDB table.
pub const AwsDynamoDbTableLocalSecondaryIndex = struct {
    /// The ARN of the index.
    index_arn: ?[]const u8,

    /// The name of the index.
    index_name: ?[]const u8,

    /// The complete key schema for the index.
    key_schema: ?[]const AwsDynamoDbTableKeySchema,

    /// Attributes that are copied from the table into the index. These are in
    /// addition to the
    /// primary key attributes and index key attributes, which are automatically
    /// projected.
    projection: ?AwsDynamoDbTableProjection,

    pub const json_field_names = .{
        .index_arn = "IndexArn",
        .index_name = "IndexName",
        .key_schema = "KeySchema",
        .projection = "Projection",
    };
};
