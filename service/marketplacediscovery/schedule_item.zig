/// A payment installment within a payment schedule term.
pub const ScheduleItem = struct {
    /// The amount to be charged on the charge date.
    charge_amount: []const u8,

    /// The date when the payment is due.
    charge_date: i64,

    pub const json_field_names = .{
        .charge_amount = "chargeAmount",
        .charge_date = "chargeDate",
    };
};
