/// A confidence interval for a statistical measurement.
pub const ConfidenceInterval = struct {
    /// The lower bound of the confidence interval.
    lower: ?f64 = null,

    /// The upper bound of the confidence interval.
    upper: ?f64 = null,

    pub const json_field_names = .{
        .lower = "lower",
        .upper = "upper",
    };
};
