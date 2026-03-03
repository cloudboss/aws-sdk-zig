const StaticFileSource = @import("static_file_source.zig").StaticFileSource;

/// A static file that contains an image.
pub const ImageStaticFile = struct {
    /// The source of the image static file.
    source: ?StaticFileSource = null,

    /// The ID of the static file that contains an image.
    static_file_id: []const u8,

    pub const json_field_names = .{
        .source = "Source",
        .static_file_id = "StaticFileId",
    };
};
