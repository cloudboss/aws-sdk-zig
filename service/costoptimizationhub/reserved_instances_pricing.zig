/// Pricing details for your recommended reserved instance.
pub const ReservedInstancesPricing = struct {
    /// The estimated cost of your recurring monthly fees for the recommended
    /// reserved instance across the month.
    estimated_monthly_amortized_reservation_cost: ?f64 = null,

    /// The remaining On-Demand cost estimated to not be covered by the recommended
    /// reserved instance, over the length of the lookback period.
    estimated_on_demand_cost: ?f64 = null,

    /// The cost of paying for the recommended reserved instance monthly.
    monthly_reservation_eligible_cost: ?f64 = null,

    /// The savings percentage relative to the total On-Demand costs that are
    /// associated with this instance.
    savings_percentage: ?f64 = null,

    pub const json_field_names = .{
        .estimated_monthly_amortized_reservation_cost = "estimatedMonthlyAmortizedReservationCost",
        .estimated_on_demand_cost = "estimatedOnDemandCost",
        .monthly_reservation_eligible_cost = "monthlyReservationEligibleCost",
        .savings_percentage = "savingsPercentage",
    };
};
