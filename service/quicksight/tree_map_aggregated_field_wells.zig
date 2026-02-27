const MeasureField = @import("measure_field.zig").MeasureField;
const DimensionField = @import("dimension_field.zig").DimensionField;

/// Aggregated field wells of a tree map.
pub const TreeMapAggregatedFieldWells = struct {
    /// The color field well of a tree map. Values are grouped by aggregations based
    /// on group by fields.
    colors: ?[]const MeasureField,

    /// The group by field well of a tree map. Values are grouped based on group by
    /// fields.
    groups: ?[]const DimensionField,

    /// The size field well of a tree map. Values are aggregated based on group by
    /// fields.
    sizes: ?[]const MeasureField,

    pub const json_field_names = .{
        .colors = "Colors",
        .groups = "Groups",
        .sizes = "Sizes",
    };
};
