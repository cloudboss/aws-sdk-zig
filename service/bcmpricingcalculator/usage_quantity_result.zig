/// Represents the result of a usage quantity calculation.
pub const UsageQuantityResult = struct {
    /// The numeric value of the usage quantity result.
    amount: ?f64,

    /// The unit of measurement for the usage quantity result.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .amount = "amount",
        .unit = "unit",
    };
};
