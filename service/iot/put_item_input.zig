/// The input for the DynamoActionVS action that specifies the DynamoDB table to
/// which
/// the message data will be written.
pub const PutItemInput = struct {
    /// The table where the message data will be written.
    table_name: []const u8,

    pub const json_field_names = .{
        .table_name = "tableName",
    };
};
