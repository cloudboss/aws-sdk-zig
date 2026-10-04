const GeoSpatialDataRole = @import("geo_spatial_data_role.zig").GeoSpatialDataRole;

/// The semantic type information for a column in the new data preparation
/// experience.
pub const ColumnSemanticType = struct {
    /// The geographical role of the column in the new data preparation experience.
    geographical_role: ?GeoSpatialDataRole = null,

    pub const json_field_names = .{
        .geographical_role = "GeographicalRole",
    };
};
