const ColumnDescription = @import("column_description.zig").ColumnDescription;
const GeoSpatialDataRole = @import("geo_spatial_data_role.zig").GeoSpatialDataRole;

/// A tag for a column in a
/// `
/// [TagColumnOperation](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_TagColumnOperation.html)
/// `
/// structure. This is a
/// variant type structure. For this structure to be valid, only one of the
/// attributes can
/// be non-null.
pub const ColumnTag = struct {
    /// A description for a column.
    column_description: ?ColumnDescription = null,

    /// A geospatial role for a column.
    column_geographic_role: ?GeoSpatialDataRole = null,

    pub const json_field_names = .{
        .column_description = "ColumnDescription",
        .column_geographic_role = "ColumnGeographicRole",
    };
};
