/// Contains the output configuration of an intermediate table when a protected
/// query populates it.
pub const IntermediateTableOutputConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the intermediate table.
    arn: []const u8,

    /// The unique identifier of the intermediate table.
    id: []const u8,

    /// The name of the intermediate table.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .name = "name",
    };
};
