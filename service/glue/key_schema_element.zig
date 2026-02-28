/// A partition key pair consisting of a name and a type.
pub const KeySchemaElement = struct {
    /// The name of a partition key.
    name: []const u8,

    /// The type of a partition key.
    @"type": []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .@"type" = "Type",
    };
};
