/// Specifies a transform that chooses the data property keys that you want to
/// drop.
pub const DropFields = struct {
    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    /// A JSON path to a variable in the data structure.
    paths: []const []const []const u8,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .name = "Name",
        .paths = "Paths",
    };
};
