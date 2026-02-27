/// Represents a usage quantity with associated unit and time period.
pub const UsageQuantity = struct {
    /// The numeric value of the usage quantity.
    amount: ?f64,

    /// The start hour of the usage period.
    start_hour: ?i64,

    /// The unit of measurement for the usage quantity.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .amount = "amount",
        .start_hour = "startHour",
        .unit = "unit",
    };
};
