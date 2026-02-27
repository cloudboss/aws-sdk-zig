/// Specifies a transform that splits data property keys into two
/// `DynamicFrames`. The output is a collection of `DynamicFrames`: one with
/// selected data property keys, and one with the remaining data property keys.
pub const SplitFields = struct {
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
