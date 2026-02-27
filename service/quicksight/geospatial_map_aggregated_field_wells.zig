const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The aggregated field wells for a geospatial map.
pub const GeospatialMapAggregatedFieldWells = struct {
    /// The color field wells of a geospatial map.
    colors: ?[]const DimensionField,

    /// The geospatial field wells of a geospatial map. Values are grouped by
    /// geospatial fields.
    geospatial: ?[]const DimensionField,

    /// The size field wells of a geospatial map. Values are aggregated based on
    /// geospatial fields.
    values: ?[]const MeasureField,

    pub const json_field_names = .{
        .colors = "Colors",
        .geospatial = "Geospatial",
        .values = "Values",
    };
};
