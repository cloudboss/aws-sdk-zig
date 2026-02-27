/// Information about a Savings Plan offering rate property.
pub const SavingsPlanOfferingRateProperty = struct {
    /// The property name.
    name: ?[]const u8,

    /// The property value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
