/// Identifier for a hours of operations resource: ARN, ID, Name
pub const HoursOfOperationsIdentifier = struct {
    /// Amazon Resource Name (ARN) of the hours of operations.
    arn: ?[]const u8 = null,

    /// Unique identifier of the hours of operation.
    id: []const u8,

    /// Name of the hours of operation
    name: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
    };
};
