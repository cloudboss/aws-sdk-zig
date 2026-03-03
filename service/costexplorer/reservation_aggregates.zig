/// The aggregated numbers for your reservation usage.
pub const ReservationAggregates = struct {
    /// The monthly cost of your reservation. It's amortized over the reservation
    /// period.
    amortized_recurring_fee: ?[]const u8 = null,

    /// The upfront cost of your reservation. It's amortized over the reservation
    /// period.
    amortized_upfront_fee: ?[]const u8 = null,

    /// How much you saved due to purchasing and utilizing reservation. Amazon Web
    /// Services
    /// calculates this by subtracting `TotalAmortizedFee` from
    /// `OnDemandCostOfRIHoursUsed`.
    net_ri_savings: ?[]const u8 = null,

    /// How much your reservation costs if charged On-Demand rates.
    on_demand_cost_of_ri_hours_used: ?[]const u8 = null,

    /// How many reservation hours that you purchased.
    purchased_hours: ?[]const u8 = null,

    /// The number of Amazon EC2 reservation hours that you purchased. It's
    /// converted to
    /// normalized units. Normalized units are available only for Amazon EC2 usage
    /// after
    /// November 11, 2017.
    purchased_units: ?[]const u8 = null,

    /// The realized savings because of purchasing and using a reservation.
    realized_savings: ?[]const u8 = null,

    /// The cost of unused hours for your reservation.
    ri_cost_for_unused_hours: ?[]const u8 = null,

    /// The total number of reservation hours that you used.
    total_actual_hours: ?[]const u8 = null,

    /// The total number of Amazon EC2 reservation hours that you used. It's
    /// converted to
    /// normalized units. Normalized units are available only for Amazon EC2 usage
    /// after
    /// November 11, 2017.
    total_actual_units: ?[]const u8 = null,

    /// The total cost of your reservation. It's amortized over the reservation
    /// period.
    total_amortized_fee: ?[]const u8 = null,

    /// How much you might save if you use your entire reservation.
    total_potential_ri_savings: ?[]const u8 = null,

    /// The unrealized savings because of purchasing and using a reservation.
    unrealized_savings: ?[]const u8 = null,

    /// The number of reservation hours that you didn't use.
    unused_hours: ?[]const u8 = null,

    /// The number of Amazon EC2 reservation hours that you didn't use. It's
    /// converted to
    /// normalized units. Normalized units are available only for Amazon EC2 usage
    /// after
    /// November 11, 2017.
    unused_units: ?[]const u8 = null,

    /// The percentage of reservation time that you used.
    utilization_percentage: ?[]const u8 = null,

    /// The percentage of Amazon EC2 reservation time that you used. It's converted
    /// to
    /// normalized units. Normalized units are available only for Amazon EC2 usage
    /// after
    /// November 11, 2017.
    utilization_percentage_in_units: ?[]const u8 = null,

    pub const json_field_names = .{
        .amortized_recurring_fee = "AmortizedRecurringFee",
        .amortized_upfront_fee = "AmortizedUpfrontFee",
        .net_ri_savings = "NetRISavings",
        .on_demand_cost_of_ri_hours_used = "OnDemandCostOfRIHoursUsed",
        .purchased_hours = "PurchasedHours",
        .purchased_units = "PurchasedUnits",
        .realized_savings = "RealizedSavings",
        .ri_cost_for_unused_hours = "RICostForUnusedHours",
        .total_actual_hours = "TotalActualHours",
        .total_actual_units = "TotalActualUnits",
        .total_amortized_fee = "TotalAmortizedFee",
        .total_potential_ri_savings = "TotalPotentialRISavings",
        .unrealized_savings = "UnrealizedSavings",
        .unused_hours = "UnusedHours",
        .unused_units = "UnusedUnits",
        .utilization_percentage = "UtilizationPercentage",
        .utilization_percentage_in_units = "UtilizationPercentageInUnits",
    };
};
