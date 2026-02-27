const Currency = @import("currency.zig").Currency;

/// Describes the estimated monthly savings amount possible, based on On-Demand
/// instance
/// pricing, by adopting Compute Optimizer recommendations for a given resource.
///
/// For more information, see [Estimated monthly savings and savings
/// opportunities](https://docs.aws.amazon.com/compute-optimizer/latest/ug/view-ec2-recommendations.html#ec2-savings-calculation) in the
/// *Compute Optimizer User Guide*.
pub const EstimatedMonthlySavings = struct {
    /// The currency of the estimated monthly
    /// savings.
    currency: ?Currency,

    /// The value of the estimated monthly savings.
    value: f64 = 0,

    pub const json_field_names = .{
        .currency = "currency",
        .value = "value",
    };
};
