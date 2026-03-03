const SavingsPlanOfferingFilterAttribute = @import("savings_plan_offering_filter_attribute.zig").SavingsPlanOfferingFilterAttribute;

/// Information about a Savings Plan offering filter.
pub const SavingsPlanOfferingFilterElement = struct {
    /// The filter name.
    name: ?SavingsPlanOfferingFilterAttribute = null,

    /// The filter values.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
