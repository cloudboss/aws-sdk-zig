const StaticFileSource = @import("static_file_source.zig").StaticFileSource;

/// A static file that contains the geospatial data.
pub const SpatialStaticFile = struct {
    /// The source of the spatial static file.
    source: ?StaticFileSource,

    /// The ID of the spatial static file.
    static_file_id: []const u8,

    pub const json_field_names = .{
        .source = "Source",
        .static_file_id = "StaticFileId",
    };
};
