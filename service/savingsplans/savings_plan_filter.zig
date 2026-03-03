const SavingsPlansFilterName = @import("savings_plans_filter_name.zig").SavingsPlansFilterName;

/// Information about a Savings Plan filter.
pub const SavingsPlanFilter = struct {
    /// The filter name.
    name: ?SavingsPlansFilterName = null,

    /// The filter value.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
