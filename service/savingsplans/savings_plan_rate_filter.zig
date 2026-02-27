const SavingsPlanRateFilterName = @import("savings_plan_rate_filter_name.zig").SavingsPlanRateFilterName;

/// Information about a Savings Plan rate filter.
pub const SavingsPlanRateFilter = struct {
    /// The filter name.
    name: ?SavingsPlanRateFilterName,

    /// The filter values.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
