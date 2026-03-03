const InstanceDetails = @import("instance_details.zig").InstanceDetails;
const ReservedCapacityDetails = @import("reserved_capacity_details.zig").ReservedCapacityDetails;

/// Details about your recommended reservation purchase.
pub const ReservationPurchaseRecommendationDetail = struct {
    /// The account that this Reserved Instance (RI) recommendation is for.
    account_id: ?[]const u8 = null,

    /// The average number of normalized units that you used in an hour during the
    /// historical
    /// period. Amazon Web Services uses this to calculate your recommended
    /// reservation
    /// purchases.
    average_normalized_units_used_per_hour: ?[]const u8 = null,

    /// The average number of provisioned capacity units that you used in an hour
    /// during the
    ///
    /// historical period. Amazon Web Services uses this to calculate your
    /// recommended
    ///
    /// reservation purchases.
    average_number_of_capacity_units_used_per_hour: ?[]const u8 = null,

    /// The average number of instances that you used in an hour during the
    /// historical period.
    /// Amazon Web Services uses this to calculate your recommended reservation
    /// purchases.
    average_number_of_instances_used_per_hour: ?[]const u8 = null,

    /// The average utilization of your instances. Amazon Web Services uses this to
    /// calculate
    /// your recommended reservation purchases.
    average_utilization: ?[]const u8 = null,

    /// The currency code that Amazon Web Services used to calculate the costs for
    /// this
    /// instance.
    currency_code: ?[]const u8 = null,

    /// How long Amazon Web Services estimates that it takes for this instance to
    /// start saving
    /// you money, in months.
    estimated_break_even_in_months: ?[]const u8 = null,

    /// How much Amazon Web Services estimates that you spend on On-Demand Instances
    /// in a
    /// month.
    estimated_monthly_on_demand_cost: ?[]const u8 = null,

    /// How much Amazon Web Services estimates that this specific recommendation
    /// might save you
    /// in a month.
    estimated_monthly_savings_amount: ?[]const u8 = null,

    /// How much Amazon Web Services estimates that this specific recommendation
    /// might save you
    /// in a month, as a percentage of your overall costs.
    estimated_monthly_savings_percentage: ?[]const u8 = null,

    /// How much Amazon Web Services estimates that you might spend for all usage
    /// during the
    /// specified historical period if you had a reservation.
    estimated_reservation_cost_for_lookback_period: ?[]const u8 = null,

    /// Details about the reservations that Amazon Web Services recommends that you
    /// purchase.
    instance_details: ?InstanceDetails = null,

    /// The maximum number of normalized units that you used in an hour during the
    /// historical
    /// period. Amazon Web Services uses this to calculate your recommended
    /// reservation
    /// purchases.
    maximum_normalized_units_used_per_hour: ?[]const u8 = null,

    /// The maximum number of provisioned capacity units that you used in an hour
    /// during the
    ///
    /// historical period. Amazon Web Services uses this to calculate your
    /// recommended
    ///
    /// reservation purchases.
    maximum_number_of_capacity_units_used_per_hour: ?[]const u8 = null,

    /// The maximum number of instances that you used in an hour during the
    /// historical period.
    /// Amazon Web Services uses this to calculate your recommended reservation
    /// purchases.
    maximum_number_of_instances_used_per_hour: ?[]const u8 = null,

    /// The minimum number of normalized units that you used in an hour during the
    /// historical
    /// period. Amazon Web Services uses this to calculate your recommended
    /// reservation
    /// purchases.
    minimum_normalized_units_used_per_hour: ?[]const u8 = null,

    /// The minimum number of provisioned capacity units that you used in an hour
    /// during the
    ///
    /// historical period. Amazon Web Services uses this to calculate your
    /// recommended
    ///
    /// reservation purchases.
    minimum_number_of_capacity_units_used_per_hour: ?[]const u8 = null,

    /// The minimum number of instances that you used in an hour during the
    /// historical period.
    /// Amazon Web Services uses this to calculate your recommended reservation
    /// purchases.
    minimum_number_of_instances_used_per_hour: ?[]const u8 = null,

    /// The number of normalized units that Amazon Web Services recommends that you
    /// purchase.
    recommended_normalized_units_to_purchase: ?[]const u8 = null,

    /// The number of reserved capacity units that Amazon Web Services recommends
    /// that you
    ///
    /// purchase.
    recommended_number_of_capacity_units_to_purchase: ?[]const u8 = null,

    /// The number of instances that Amazon Web Services recommends that you
    /// purchase.
    recommended_number_of_instances_to_purchase: ?[]const u8 = null,

    /// How much purchasing this instance costs you on a monthly basis.
    recurring_standard_monthly_cost: ?[]const u8 = null,

    /// Details about the reservations that Amazon Web Services recommends that you
    ///
    /// purchase.
    reserved_capacity_details: ?ReservedCapacityDetails = null,

    /// How much purchasing this instance costs you upfront.
    upfront_cost: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .average_normalized_units_used_per_hour = "AverageNormalizedUnitsUsedPerHour",
        .average_number_of_capacity_units_used_per_hour = "AverageNumberOfCapacityUnitsUsedPerHour",
        .average_number_of_instances_used_per_hour = "AverageNumberOfInstancesUsedPerHour",
        .average_utilization = "AverageUtilization",
        .currency_code = "CurrencyCode",
        .estimated_break_even_in_months = "EstimatedBreakEvenInMonths",
        .estimated_monthly_on_demand_cost = "EstimatedMonthlyOnDemandCost",
        .estimated_monthly_savings_amount = "EstimatedMonthlySavingsAmount",
        .estimated_monthly_savings_percentage = "EstimatedMonthlySavingsPercentage",
        .estimated_reservation_cost_for_lookback_period = "EstimatedReservationCostForLookbackPeriod",
        .instance_details = "InstanceDetails",
        .maximum_normalized_units_used_per_hour = "MaximumNormalizedUnitsUsedPerHour",
        .maximum_number_of_capacity_units_used_per_hour = "MaximumNumberOfCapacityUnitsUsedPerHour",
        .maximum_number_of_instances_used_per_hour = "MaximumNumberOfInstancesUsedPerHour",
        .minimum_normalized_units_used_per_hour = "MinimumNormalizedUnitsUsedPerHour",
        .minimum_number_of_capacity_units_used_per_hour = "MinimumNumberOfCapacityUnitsUsedPerHour",
        .minimum_number_of_instances_used_per_hour = "MinimumNumberOfInstancesUsedPerHour",
        .recommended_normalized_units_to_purchase = "RecommendedNormalizedUnitsToPurchase",
        .recommended_number_of_capacity_units_to_purchase = "RecommendedNumberOfCapacityUnitsToPurchase",
        .recommended_number_of_instances_to_purchase = "RecommendedNumberOfInstancesToPurchase",
        .recurring_standard_monthly_cost = "RecurringStandardMonthlyCost",
        .reserved_capacity_details = "ReservedCapacityDetails",
        .upfront_cost = "UpfrontCost",
    };
};
