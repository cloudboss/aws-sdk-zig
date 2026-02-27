pub const MetricName = enum {
    amortized_cost,
    blended_cost,
    net_amortized_cost,
    net_unblended_cost,
    normalized_usage_amount,
    unblended_cost,
    usage_quantity,
    spend_covered_by_savings_plans,
    hour,
    unit,
    cost,

    pub const json_field_names = .{
        .amortized_cost = "AmortizedCost",
        .blended_cost = "BlendedCost",
        .net_amortized_cost = "NetAmortizedCost",
        .net_unblended_cost = "NetUnblendedCost",
        .normalized_usage_amount = "NormalizedUsageAmount",
        .unblended_cost = "UnblendedCost",
        .usage_quantity = "UsageQuantity",
        .spend_covered_by_savings_plans = "SpendCoveredBySavingsPlans",
        .hour = "Hour",
        .unit = "Unit",
        .cost = "Cost",
    };
};
