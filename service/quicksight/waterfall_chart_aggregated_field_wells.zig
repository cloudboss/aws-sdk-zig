const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The field well configuration of a waterfall visual.
pub const WaterfallChartAggregatedFieldWells = struct {
    /// The breakdown field wells of a waterfall visual.
    breakdowns: ?[]const DimensionField,

    /// The category field wells of a waterfall visual.
    categories: ?[]const DimensionField,

    /// The value field wells of a waterfall visual.
    values: ?[]const MeasureField,

    pub const json_field_names = .{
        .breakdowns = "Breakdowns",
        .categories = "Categories",
        .values = "Values",
    };
};
