const MessageFormatValue = @import("message_format_value.zig").MessageFormatValue;

/// Provides information that describes an Amazon Kinesis Data Stream endpoint.
/// This
/// information includes the output format of records applied to the endpoint
/// and details of
/// transaction and control table data information.
pub const KinesisSettings = struct {
    /// Shows detailed control information for table definition, column definition,
    /// and table
    /// and column changes in the Kinesis message output. The default is `false`.
    include_control_details: ?bool,

    /// Include NULL and empty columns for records migrated to the endpoint. The
    /// default is
    /// `false`.
    include_null_and_empty: ?bool,

    /// Shows the partition value within the Kinesis message output, unless the
    /// partition type
    /// is `schema-table-type`. The default is `false`.
    include_partition_value: ?bool,

    /// Includes any data definition language (DDL) operations that change the table
    /// in the
    /// control data, such as `rename-table`, `drop-table`,
    /// `add-column`, `drop-column`, and `rename-column`. The
    /// default is `false`.
    include_table_alter_operations: ?bool,

    /// Provides detailed transaction information from the source database. This
    /// information
    /// includes a commit timestamp, a log position, and values for
    /// `transaction_id`,
    /// previous `transaction_id`, and `transaction_record_id` (the record
    /// offset within a transaction). The default is `false`.
    include_transaction_details: ?bool,

    /// The output format for the records created on the endpoint. The message
    /// format is
    /// `JSON` (default) or `JSON_UNFORMATTED` (a single line with no
    /// tab).
    message_format: ?MessageFormatValue,

    /// Set this optional parameter to `true` to avoid adding a '0x' prefix
    /// to raw data in hexadecimal format. For example, by default, DMS adds a '0x'
    /// prefix to the LOB column type in hexadecimal format moving from an Oracle
    /// source to an
    /// Amazon Kinesis target. Use the `NoHexPrefix` endpoint setting to enable
    /// migration of RAW data type columns without adding the '0x' prefix.
    no_hex_prefix: ?bool,

    /// Prefixes schema and table names to partition values, when the partition type
    /// is
    /// `primary-key-type`. Doing this increases data distribution among Kinesis
    /// shards. For example, suppose that a SysBench schema has thousands of tables
    /// and each table
    /// has only limited range for a primary key. In this case, the same primary key
    /// is sent from
    /// thousands of tables to the same shard, which causes throttling. The default
    /// is
    /// `false`.
    partition_include_schema_table: ?bool,

    /// The Amazon Resource Name (ARN) for the IAM role that DMS uses to write to
    /// the Kinesis
    /// data stream. The role must allow the `iam:PassRole` action.
    service_access_role_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the Amazon Kinesis Data Streams endpoint.
    stream_arn: ?[]const u8,

    /// Specifies using the large integer value with Kinesis.
    use_large_integer_value: ?bool,

    pub const json_field_names = .{
        .include_control_details = "IncludeControlDetails",
        .include_null_and_empty = "IncludeNullAndEmpty",
        .include_partition_value = "IncludePartitionValue",
        .include_table_alter_operations = "IncludeTableAlterOperations",
        .include_transaction_details = "IncludeTransactionDetails",
        .message_format = "MessageFormat",
        .no_hex_prefix = "NoHexPrefix",
        .partition_include_schema_table = "PartitionIncludeSchemaTable",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .stream_arn = "StreamArn",
        .use_large_integer_value = "UseLargeIntegerValue",
    };
};
