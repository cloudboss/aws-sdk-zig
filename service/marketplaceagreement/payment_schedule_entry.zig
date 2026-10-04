/// A single installment in a payment schedule template. Because the start date
/// of the renewed agreement isn't known when the offer is created, the charge
/// date of each installment is expressed as an offset from that start date
/// rather than as an absolute date.
pub const PaymentScheduleEntry = struct {
    /// The time between the start date of the renewed agreement and the date this
    /// installment is charged. The duration is represented in the ISO 8601 format
    /// in either whole months or whole days (for example, `P1M` for 1 month or
    /// `P30D` for 30 days). All installments in a schedule use the same unit.
    charge_date_offset: ?[]const u8 = null,

    /// The percentage of the total contract value of the renewed agreement that is
    /// charged in this installment. Valid values range from `0.01` to `100.00`,
    /// with up to two decimal places.
    charge_percentage: ?[]const u8 = null,

    /// The day of the month on which this installment is charged, from `1` to `31`.
    /// Use this field to anchor the charge to a specific calendar day within the
    /// month identified by `ChargeDateOffset`. This field is supported only when
    /// `ChargeDateOffset` is expressed in months.
    day_of_month: ?i32 = null,

    pub const json_field_names = .{
        .charge_date_offset = "chargeDateOffset",
        .charge_percentage = "chargePercentage",
        .day_of_month = "dayOfMonth",
    };
};
