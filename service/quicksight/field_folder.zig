/// A FieldFolder element is a folder that contains fields and nested
/// subfolders.
pub const FieldFolder = struct {
    /// A folder has a list of columns. A column can only be in one folder.
    columns: ?[]const []const u8,

    /// The description for a field folder.
    description: ?[]const u8,

    pub const json_field_names = .{
        .columns = "columns",
        .description = "description",
    };
};
