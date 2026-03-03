const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The aggregated field well of the filled map.
pub const FilledMapAggregatedFieldWells = struct {
    /// The aggregated location field well of the filled map. Values are grouped by
    /// location fields.
    geospatial: ?[]const DimensionField = null,

    /// The aggregated color field well of a filled map. Values are aggregated based
    /// on location fields.
    values: ?[]const MeasureField = null,

    pub const json_field_names = .{
        .geospatial = "Geospatial",
        .values = "Values",
    };
};
