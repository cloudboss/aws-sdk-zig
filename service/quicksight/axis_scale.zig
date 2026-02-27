const AxisLinearScale = @import("axis_linear_scale.zig").AxisLinearScale;
const AxisLogarithmicScale = @import("axis_logarithmic_scale.zig").AxisLogarithmicScale;

/// The scale setup
/// options for a numeric axis display.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const AxisScale = struct {
    /// The linear axis scale setup.
    linear: ?AxisLinearScale,

    /// The logarithmic axis scale setup.
    logarithmic: ?AxisLogarithmicScale,

    pub const json_field_names = .{
        .linear = "Linear",
        .logarithmic = "Logarithmic",
    };
};
