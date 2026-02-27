/// Specifies a transform that removes rows of repeating data from a data set.
pub const DropDuplicates = struct {
    /// The name of the columns to be merged or removed if repeating.
    columns: ?[]const []const []const u8,

    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    pub const json_field_names = .{
        .columns = "Columns",
        .inputs = "Inputs",
        .name = "Name",
    };
};
