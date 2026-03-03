const MeasureField = @import("measure_field.zig").MeasureField;
const DimensionField = @import("dimension_field.zig").DimensionField;

/// Aggregated field wells of a tree map.
pub const TreeMapAggregatedFieldWells = struct {
    /// The color field well of a tree map. Values are grouped by aggregations based
    /// on group by fields.
    colors: ?[]const MeasureField = null,

    /// The group by field well of a tree map. Values are grouped based on group by
    /// fields.
    groups: ?[]const DimensionField = null,

    /// The size field well of a tree map. Values are aggregated based on group by
    /// fields.
    sizes: ?[]const MeasureField = null,

    pub const json_field_names = .{
        .colors = "Colors",
        .groups = "Groups",
        .sizes = "Sizes",
    };
};
