/// Specifies a transform that renames a single data property key.
pub const RenameField = struct {
    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    /// A JSON path to a variable in the data structure for the source data.
    source_path: []const []const u8,

    /// A JSON path to a variable in the data structure for the target data.
    target_path: []const []const u8,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .name = "Name",
        .source_path = "SourcePath",
        .target_path = "TargetPath",
    };
};
