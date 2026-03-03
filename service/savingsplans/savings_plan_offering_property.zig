const SavingsPlanOfferingPropertyKey = @import("savings_plan_offering_property_key.zig").SavingsPlanOfferingPropertyKey;

/// Information about a Savings Plan offering property.
pub const SavingsPlanOfferingProperty = struct {
    /// The property name.
    name: ?SavingsPlanOfferingPropertyKey = null,

    /// The property value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
