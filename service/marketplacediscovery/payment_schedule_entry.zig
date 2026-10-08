/// A single installment entry in the renewal payment schedule.
pub const PaymentScheduleEntry = struct {
    /// The relative offset from the renewal agreement start date when this
    /// installment is due, represented in ISO 8601 duration format (for example,
    /// P1M or P30D).
    charge_date_offset: []const u8,

    /// The percentage of the increased Total Contract Value (TCV) to charge in this
    /// installment. All entries in a schedule sum to 100.00.
    charge_percentage: []const u8,

    /// The optional calendar day of month on which the charge occurs. When absent,
    /// the charge day is derived from `chargeDateOffset`. For months with fewer
    /// days than the specified day, the charge occurs on the last day of the month.
    /// For example, if `dayOfMonth` is 31, the charge in April occurs on April 30.
    day_of_month: ?i32 = null,

    pub const json_field_names = .{
        .charge_date_offset = "chargeDateOffset",
        .charge_percentage = "chargePercentage",
        .day_of_month = "dayOfMonth",
    };
};
