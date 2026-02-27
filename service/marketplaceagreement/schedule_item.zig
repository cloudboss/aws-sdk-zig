/// An individual installment of the payment that includes the date and amount
/// of the charge.
pub const ScheduleItem = struct {
    /// The price that the customer would pay on the scheduled date (chargeDate).
    charge_amount: ?[]const u8,

    /// The date that the customer would pay the price defined in this payment
    /// schedule term. Invoices are generated on the date provided.
    charge_date: ?i64,

    pub const json_field_names = .{
        .charge_amount = "chargeAmount",
        .charge_date = "chargeDate",
    };
};
