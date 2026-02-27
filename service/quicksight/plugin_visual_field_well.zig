const PluginVisualAxisName = @import("plugin_visual_axis_name.zig").PluginVisualAxisName;
const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;
const UnaggregatedField = @import("unaggregated_field.zig").UnaggregatedField;

/// A collection of field wells for a plugin visual.
pub const PluginVisualFieldWell = struct {
    /// The semantic axis name for the field well.
    axis_name: ?PluginVisualAxisName,

    /// A list of dimensions for the field well.
    dimensions: ?[]const DimensionField,

    /// A list of measures that exist in the field well.
    measures: ?[]const MeasureField,

    /// A list of unaggregated fields that exist in the field well.
    unaggregated: ?[]const UnaggregatedField,

    pub const json_field_names = .{
        .axis_name = "AxisName",
        .dimensions = "Dimensions",
        .measures = "Measures",
        .unaggregated = "Unaggregated",
    };
};
