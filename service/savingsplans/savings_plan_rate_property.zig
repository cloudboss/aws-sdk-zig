const SavingsPlanRatePropertyKey = @import("savings_plan_rate_property_key.zig").SavingsPlanRatePropertyKey;

/// Information about a Savings Plan rate property.
pub const SavingsPlanRateProperty = struct {
    /// The property name.
    name: ?SavingsPlanRatePropertyKey = null,

    /// The property value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
