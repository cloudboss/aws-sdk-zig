const OutputFile = @import("output_file.zig").OutputFile;

/// Contains intermediate response for code interpreter if any files have been
/// generated.
pub const FilePart = struct {
    /// Files containing intermediate response for the user.
    files: ?[]const OutputFile = null,

    pub const json_field_names = .{
        .files = "files",
    };
};
