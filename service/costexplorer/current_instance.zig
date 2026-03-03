const ResourceDetails = @import("resource_details.zig").ResourceDetails;
const ResourceUtilization = @import("resource_utilization.zig").ResourceUtilization;
const TagValues = @import("tag_values.zig").TagValues;

/// Context about the current instance.
pub const CurrentInstance = struct {
    /// The currency code that Amazon Web Services used to calculate the costs for
    /// this
    /// instance.
    currency_code: ?[]const u8 = null,

    /// The name that you given an instance. This field shows as blank if you
    /// haven't given
    /// the instance a name.
    instance_name: ?[]const u8 = null,

    /// The current On-Demand cost of operating this instance on a monthly basis.
    monthly_cost: ?[]const u8 = null,

    /// The number of hours during the lookback period that's billed at On-Demand
    /// rates.
    on_demand_hours_in_lookback_period: ?[]const u8 = null,

    /// The number of hours during the lookback period that's covered by
    /// reservations.
    reservation_covered_hours_in_lookback_period: ?[]const u8 = null,

    /// Details about the resource and utilization.
    resource_details: ?ResourceDetails = null,

    /// Resource ID of the current instance.
    resource_id: ?[]const u8 = null,

    /// Utilization information of the current instance during the lookback period.
    resource_utilization: ?ResourceUtilization = null,

    /// The number of hours during the lookback period that's covered by Savings
    /// Plans.
    savings_plans_covered_hours_in_lookback_period: ?[]const u8 = null,

    /// Cost allocation resource tags that are applied to the instance.
    tags: ?[]const TagValues = null,

    /// The total number of hours that the instance ran during the lookback period.
    total_running_hours_in_lookback_period: ?[]const u8 = null,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .instance_name = "InstanceName",
        .monthly_cost = "MonthlyCost",
        .on_demand_hours_in_lookback_period = "OnDemandHoursInLookbackPeriod",
        .reservation_covered_hours_in_lookback_period = "ReservationCoveredHoursInLookbackPeriod",
        .resource_details = "ResourceDetails",
        .resource_id = "ResourceId",
        .resource_utilization = "ResourceUtilization",
        .savings_plans_covered_hours_in_lookback_period = "SavingsPlansCoveredHoursInLookbackPeriod",
        .tags = "Tags",
        .total_running_hours_in_lookback_period = "TotalRunningHoursInLookbackPeriod",
    };
};
