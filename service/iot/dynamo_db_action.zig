const DynamoKeyType = @import("dynamo_key_type.zig").DynamoKeyType;

/// Describes an action to write to a DynamoDB table.
///
/// The `tableName`, `hashKeyField`, and `rangeKeyField`
/// values must match the values used when you created the table.
///
/// The `hashKeyValue` and `rangeKeyvalue` fields use a
/// substitution template syntax. These templates provide data at runtime. The
/// syntax is as
/// follows: ${*sql-expression*}.
///
/// You can specify any valid expression in a WHERE or SELECT clause, including
/// JSON
/// properties, comparisons, calculations, and functions. For example, the
/// following field uses
/// the third level of the topic:
///
/// `"hashKeyValue": "${topic(3)}"`
///
/// The following field uses the timestamp:
///
/// `"rangeKeyValue": "${timestamp()}"`
pub const DynamoDBAction = struct {
    /// The hash key name.
    hash_key_field: []const u8,

    /// The hash key type. Valid values are "STRING" or "NUMBER"
    hash_key_type: ?DynamoKeyType = null,

    /// The hash key value.
    hash_key_value: []const u8,

    /// The type of operation to be performed. This follows the substitution
    /// template, so it
    /// can be `${operation}`, but the substitution must result in one of the
    /// following:
    /// `INSERT`, `UPDATE`, or `DELETE`.
    operation: ?[]const u8 = null,

    /// The action payload. This name can be customized.
    payload_field: ?[]const u8 = null,

    /// The range key name.
    range_key_field: ?[]const u8 = null,

    /// The range key type. Valid values are "STRING" or "NUMBER"
    range_key_type: ?DynamoKeyType = null,

    /// The range key value.
    range_key_value: ?[]const u8 = null,

    /// The ARN of the IAM role that grants access to the DynamoDB table.
    role_arn: []const u8,

    /// The name of the DynamoDB table.
    table_name: []const u8,

    pub const json_field_names = .{
        .hash_key_field = "hashKeyField",
        .hash_key_type = "hashKeyType",
        .hash_key_value = "hashKeyValue",
        .operation = "operation",
        .payload_field = "payloadField",
        .range_key_field = "rangeKeyField",
        .range_key_type = "rangeKeyType",
        .range_key_value = "rangeKeyValue",
        .role_arn = "roleArn",
        .table_name = "tableName",
    };
};
