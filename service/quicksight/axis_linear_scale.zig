/// The liner axis scale setup.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const AxisLinearScale = struct {
    /// The step count setup of a linear axis.
    step_count: ?i32,

    /// The step size setup of a linear axis.
    step_size: ?f64,

    pub const json_field_names = .{
        .step_count = "StepCount",
        .step_size = "StepSize",
    };
};
