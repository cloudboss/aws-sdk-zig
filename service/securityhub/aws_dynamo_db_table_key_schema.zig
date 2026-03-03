/// A component of the key schema for the DynamoDB table, a global secondary
/// index, or a
/// local secondary index.
pub const AwsDynamoDbTableKeySchema = struct {
    /// The name of the key schema attribute.
    attribute_name: ?[]const u8 = null,

    /// The type of key used for the key schema attribute. Valid values are `HASH`
    /// or `RANGE`.
    key_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .key_type = "KeyType",
    };
};
