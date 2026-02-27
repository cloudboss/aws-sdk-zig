const PathFormat = @import("path_format.zig").PathFormat;

/// The details of a source and destination path.
pub const PathMappingRule = struct {
    /// The destination path.
    destination_path: []const u8,

    /// The source path.
    source_path: []const u8,

    /// The source path format.
    source_path_format: PathFormat,

    pub const json_field_names = .{
        .destination_path = "destinationPath",
        .source_path = "sourcePath",
        .source_path_format = "sourcePathFormat",
    };
};
