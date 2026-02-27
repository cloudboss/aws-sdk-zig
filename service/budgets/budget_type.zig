/// The type of a budget. It must be one of the following types:
///
/// `COST`, `USAGE`, `RI_UTILIZATION`,
/// `RI_COVERAGE`, `SAVINGS_PLANS_UTILIZATION`, or
/// `SAVINGS_PLANS_COVERAGE`.
pub const BudgetType = enum {
    usage,
    cost,
    ri_utilization,
    ri_coverage,
    sp_utilization,
    sp_coverage,

    pub const json_field_names = .{
        .usage = "Usage",
        .cost = "Cost",
        .ri_utilization = "RIUtilization",
        .ri_coverage = "RICoverage",
        .sp_utilization = "SPUtilization",
        .sp_coverage = "SPCoverage",
    };
};
