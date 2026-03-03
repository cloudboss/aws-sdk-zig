/// An element in the hierarchical path to a table within a data source,
/// containing both name and identifier.
pub const TablePathElement = struct {
    /// The unique identifier of the path element.
    id: ?[]const u8 = null,

    /// The name of the path element.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
    };
};
