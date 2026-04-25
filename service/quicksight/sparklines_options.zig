const LineChartMarkerStyleSettings = @import("line_chart_marker_style_settings.zig").LineChartMarkerStyleSettings;
const LineInterpolation = @import("line_interpolation.zig").LineInterpolation;
const SparklineVisualType = @import("sparkline_visual_type.zig").SparklineVisualType;
const DimensionField = @import("dimension_field.zig").DimensionField;
const SparklineAxisBehavior = @import("sparkline_axis_behavior.zig").SparklineAxisBehavior;

/// The options for sparklines in a table.
pub const SparklinesOptions = struct {
    all_points_marker: ?LineChartMarkerStyleSettings = null,

    /// The field ID of the value column that the sparkline is applied to.
    field_id: []const u8,

    /// The color of the sparkline line.
    line_color: ?[]const u8 = null,

    /// The interpolation style for the sparkline line.
    line_interpolation: ?LineInterpolation = null,

    max_value_marker: ?LineChartMarkerStyleSettings = null,

    min_value_marker: ?LineChartMarkerStyleSettings = null,

    /// The type of the sparkline. Valid values are `LINE` and `AREA_LINE`.
    visual_type: ?SparklineVisualType = null,

    x_axis_field: DimensionField,

    /// Determines whether the Y axis is shared across all sparklines or independent
    /// for each sparkline.
    y_axis_behavior: ?SparklineAxisBehavior = null,

    pub const json_field_names = .{
        .all_points_marker = "AllPointsMarker",
        .field_id = "FieldId",
        .line_color = "LineColor",
        .line_interpolation = "LineInterpolation",
        .max_value_marker = "MaxValueMarker",
        .min_value_marker = "MinValueMarker",
        .visual_type = "VisualType",
        .x_axis_field = "XAxisField",
        .y_axis_behavior = "YAxisBehavior",
    };
};
