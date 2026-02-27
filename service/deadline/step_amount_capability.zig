/// The details outlining the minimum and maximum capability of a step.
pub const StepAmountCapability = struct {
    /// The maximum amount.
    max: ?f64,

    /// The minimum amount.
    min: ?f64,

    /// The name of the step.
    name: []const u8,

    /// The amount value.
    value: ?f64,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
        .name = "name",
        .value = "value",
    };
};
