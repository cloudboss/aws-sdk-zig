const AwsDynamoDbTableAttributeDefinition = @import("aws_dynamo_db_table_attribute_definition.zig").AwsDynamoDbTableAttributeDefinition;
const AwsDynamoDbTableBillingModeSummary = @import("aws_dynamo_db_table_billing_mode_summary.zig").AwsDynamoDbTableBillingModeSummary;
const AwsDynamoDbTableGlobalSecondaryIndex = @import("aws_dynamo_db_table_global_secondary_index.zig").AwsDynamoDbTableGlobalSecondaryIndex;
const AwsDynamoDbTableKeySchema = @import("aws_dynamo_db_table_key_schema.zig").AwsDynamoDbTableKeySchema;
const AwsDynamoDbTableLocalSecondaryIndex = @import("aws_dynamo_db_table_local_secondary_index.zig").AwsDynamoDbTableLocalSecondaryIndex;
const AwsDynamoDbTableProvisionedThroughput = @import("aws_dynamo_db_table_provisioned_throughput.zig").AwsDynamoDbTableProvisionedThroughput;
const AwsDynamoDbTableReplica = @import("aws_dynamo_db_table_replica.zig").AwsDynamoDbTableReplica;
const AwsDynamoDbTableRestoreSummary = @import("aws_dynamo_db_table_restore_summary.zig").AwsDynamoDbTableRestoreSummary;
const AwsDynamoDbTableSseDescription = @import("aws_dynamo_db_table_sse_description.zig").AwsDynamoDbTableSseDescription;
const AwsDynamoDbTableStreamSpecification = @import("aws_dynamo_db_table_stream_specification.zig").AwsDynamoDbTableStreamSpecification;

/// Provides details about a DynamoDB table.
pub const AwsDynamoDbTableDetails = struct {
    /// A list of attribute definitions for the table.
    attribute_definitions: ?[]const AwsDynamoDbTableAttributeDefinition = null,

    /// Information about the billing for read/write capacity on the table.
    billing_mode_summary: ?AwsDynamoDbTableBillingModeSummary = null,

    /// Indicates when the table was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    creation_date_time: ?[]const u8 = null,

    /// Indicates whether deletion protection is to be enabled (true) or disabled
    /// (false) on the table.
    deletion_protection_enabled: ?bool = null,

    /// List of global secondary indexes for the table.
    global_secondary_indexes: ?[]const AwsDynamoDbTableGlobalSecondaryIndex = null,

    /// The version of global tables being used.
    global_table_version: ?[]const u8 = null,

    /// The number of items in the table.
    item_count: ?i32 = null,

    /// The primary key structure for the table.
    key_schema: ?[]const AwsDynamoDbTableKeySchema = null,

    /// The ARN of the latest stream for the table.
    latest_stream_arn: ?[]const u8 = null,

    /// The label of the latest stream. The label is not a unique identifier.
    latest_stream_label: ?[]const u8 = null,

    /// The list of local secondary indexes for the table.
    local_secondary_indexes: ?[]const AwsDynamoDbTableLocalSecondaryIndex = null,

    /// Information about the provisioned throughput for the table.
    provisioned_throughput: ?AwsDynamoDbTableProvisionedThroughput = null,

    /// The list of replicas of this table.
    replicas: ?[]const AwsDynamoDbTableReplica = null,

    /// Information about the restore for the table.
    restore_summary: ?AwsDynamoDbTableRestoreSummary = null,

    /// Information about the server-side encryption for the table.
    sse_description: ?AwsDynamoDbTableSseDescription = null,

    /// The current DynamoDB Streams configuration for the table.
    stream_specification: ?AwsDynamoDbTableStreamSpecification = null,

    /// The identifier of the table.
    table_id: ?[]const u8 = null,

    /// The name of the table.
    table_name: ?[]const u8 = null,

    /// The total size of the table in bytes.
    table_size_bytes: ?i64 = null,

    /// The current status of the table. Valid values are as follows:
    ///
    /// * `ACTIVE`
    ///
    /// * `ARCHIVED`
    ///
    /// * `ARCHIVING`
    ///
    /// * `CREATING`
    ///
    /// * `DELETING`
    ///
    /// * `INACCESSIBLE_ENCRYPTION_CREDENTIALS`
    ///
    /// * `UPDATING`
    table_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_definitions = "AttributeDefinitions",
        .billing_mode_summary = "BillingModeSummary",
        .creation_date_time = "CreationDateTime",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .global_secondary_indexes = "GlobalSecondaryIndexes",
        .global_table_version = "GlobalTableVersion",
        .item_count = "ItemCount",
        .key_schema = "KeySchema",
        .latest_stream_arn = "LatestStreamArn",
        .latest_stream_label = "LatestStreamLabel",
        .local_secondary_indexes = "LocalSecondaryIndexes",
        .provisioned_throughput = "ProvisionedThroughput",
        .replicas = "Replicas",
        .restore_summary = "RestoreSummary",
        .sse_description = "SseDescription",
        .stream_specification = "StreamSpecification",
        .table_id = "TableId",
        .table_name = "TableName",
        .table_size_bytes = "TableSizeBytes",
        .table_status = "TableStatus",
    };
};
