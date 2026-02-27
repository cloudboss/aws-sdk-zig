/// The source properties for a geospatial static file.
pub const GeospatialStaticFileSource = struct {
    /// The ID of the static file.
    static_file_id: []const u8,

    pub const json_field_names = .{
        .static_file_id = "StaticFileId",
    };
};
