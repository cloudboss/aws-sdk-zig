const NumericOperator = @import("numeric_operator.zig").NumericOperator;

/// Filters cost anomalies based on the total impact.
pub const TotalImpactFilter = struct {
    /// The upper bound dollar value that's used in the filter.
    end_value: f64 = 0,

    /// The comparing value that's used in the filter.
    numeric_operator: NumericOperator,

    /// The lower bound dollar value that's used in the filter.
    start_value: f64 = 0,

    pub const json_field_names = .{
        .end_value = "EndValue",
        .numeric_operator = "NumericOperator",
        .start_value = "StartValue",
    };
};
