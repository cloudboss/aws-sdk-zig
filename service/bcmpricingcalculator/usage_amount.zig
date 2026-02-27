/// Represents a usage amount for a specific time period.
pub const UsageAmount = struct {
    /// The usage amount for the period.
    amount: f64,

    /// The start hour of the usage period.
    start_hour: i64,

    pub const json_field_names = .{
        .amount = "amount",
        .start_hour = "startHour",
    };
};
