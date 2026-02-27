const aws = @import("aws");

const CostDifference = @import("cost_difference.zig").CostDifference;

/// Provides a summary of cost-related information for a bill estimate.
pub const BillEstimateCostSummary = struct {
    /// A breakdown of cost differences by Amazon Web Services service.
    service_cost_differences: ?[]const aws.map.MapEntry(CostDifference),

    /// The total difference in cost between the estimated and historical costs.
    total_cost_difference: ?CostDifference,

    pub const json_field_names = .{
        .service_cost_differences = "serviceCostDifferences",
        .total_cost_difference = "totalCostDifference",
    };
};
