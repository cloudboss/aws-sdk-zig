const SavingsPlansFilterName = @import("savings_plans_filter_name.zig").SavingsPlansFilterName;

/// Information about a Savings Plan filter.
pub const SavingsPlanFilter = struct {
    /// The filter name.
    name: ?SavingsPlansFilterName,

    /// The filter value.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
