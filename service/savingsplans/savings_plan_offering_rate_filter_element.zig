const SavingsPlanRateFilterAttribute = @import("savings_plan_rate_filter_attribute.zig").SavingsPlanRateFilterAttribute;

/// Information about a Savings Plan offering rate filter.
pub const SavingsPlanOfferingRateFilterElement = struct {
    /// The filter name.
    name: ?SavingsPlanRateFilterAttribute,

    /// The filter values.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
