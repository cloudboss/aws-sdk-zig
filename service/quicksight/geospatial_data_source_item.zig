const GeospatialStaticFileSource = @import("geospatial_static_file_source.zig").GeospatialStaticFileSource;

/// The data source properties for the geospatial data.
pub const GeospatialDataSourceItem = struct {
    /// The static file data source properties for the geospatial data.
    static_file_data_source: ?GeospatialStaticFileSource = null,

    pub const json_field_names = .{
        .static_file_data_source = "StaticFileDataSource",
    };
};
