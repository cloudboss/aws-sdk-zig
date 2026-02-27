const GeoSpatialCountryCode = @import("geo_spatial_country_code.zig").GeoSpatialCountryCode;

/// Geospatial column group that denotes a hierarchy.
pub const GeoSpatialColumnGroup = struct {
    /// Columns in this hierarchy.
    columns: []const []const u8,

    /// Country code.
    country_code: ?GeoSpatialCountryCode,

    /// A display name for the hierarchy.
    name: []const u8,

    pub const json_field_names = .{
        .columns = "Columns",
        .country_code = "CountryCode",
        .name = "Name",
    };
};
