const PutItemInput = @import("put_item_input.zig").PutItemInput;

/// Describes an action to write to a DynamoDB table.
///
/// This DynamoDB action writes each attribute in the message payload into it's
/// own
/// column in the DynamoDB table.
pub const DynamoDBv2Action = struct {
    /// Specifies the DynamoDB table to which the message data will be written. For
    /// example:
    ///
    /// `{ "dynamoDBv2": { "roleArn": "aws:iam:12341251:my-role" "putItem": {
    /// "tableName":
    /// "my-table" } } }`
    ///
    /// Each attribute in the message payload will be written to a separate column
    /// in the
    /// DynamoDB database.
    put_item: PutItemInput,

    /// The ARN of the IAM role that grants access to the DynamoDB table.
    role_arn: []const u8,

    pub const json_field_names = .{
        .put_item = "putItem",
        .role_arn = "roleArn",
    };
};
