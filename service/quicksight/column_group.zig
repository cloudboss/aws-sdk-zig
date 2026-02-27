const GeoSpatialColumnGroup = @import("geo_spatial_column_group.zig").GeoSpatialColumnGroup;

/// Groupings of columns that work together in certain Quick Sight features.
/// This is
/// a variant type structure. For this structure to be valid, only one of the
/// attributes can
/// be non-null.
pub const ColumnGroup = struct {
    /// Geospatial column group that denotes a hierarchy.
    geo_spatial_column_group: ?GeoSpatialColumnGroup,

    pub const json_field_names = .{
        .geo_spatial_column_group = "GeoSpatialColumnGroup",
    };
};
