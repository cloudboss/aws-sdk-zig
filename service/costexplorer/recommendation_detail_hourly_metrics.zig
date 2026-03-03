/// Contains the hourly metrics for the given recommendation over the lookback
/// period.
pub const RecommendationDetailHourlyMetrics = struct {
    /// The current amount of Savings Plans eligible usage that the Savings Plan
    /// covered.
    current_coverage: ?[]const u8 = null,

    /// The estimated coverage amount based on the recommended Savings Plan.
    estimated_coverage: ?[]const u8 = null,

    /// The estimated utilization for the recommended Savings Plan.
    estimated_new_commitment_utilization: ?[]const u8 = null,

    /// The remaining On-Demand cost estimated to not be covered by the recommended
    /// Savings
    /// Plan, over the length of the lookback period.
    estimated_on_demand_cost: ?[]const u8 = null,

    start_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_coverage = "CurrentCoverage",
        .estimated_coverage = "EstimatedCoverage",
        .estimated_new_commitment_utilization = "EstimatedNewCommitmentUtilization",
        .estimated_on_demand_cost = "EstimatedOnDemandCost",
        .start_time = "StartTime",
    };
};
