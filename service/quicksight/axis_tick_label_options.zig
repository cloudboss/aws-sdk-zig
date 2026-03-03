const LabelOptions = @import("label_options.zig").LabelOptions;

/// The tick label options of an axis.
pub const AxisTickLabelOptions = struct {
    /// Determines whether or not the axis ticks are visible.
    label_options: ?LabelOptions = null,

    /// The rotation angle of the axis tick labels.
    rotation_angle: ?f64 = null,

    pub const json_field_names = .{
        .label_options = "LabelOptions",
        .rotation_angle = "RotationAngle",
    };
};
