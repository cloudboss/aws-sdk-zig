const ScheduleItem = @import("schedule_item.zig").ScheduleItem;
const TermType = @import("term_type.zig").TermType;

/// Defines a payment schedule term with installment payments at specified
/// dates.
pub const PaymentScheduleTerm = struct {
    /// Defines the currency for the prices in this term.
    currency_code: []const u8,

    /// The unique identifier of the term.
    id: []const u8,

    /// The payment schedule installments, each with a charge date and amount.
    schedule: []const ScheduleItem,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .currency_code = "currencyCode",
        .id = "id",
        .schedule = "schedule",
        .type = "type",
    };
};
