const ScheduleItem = @import("schedule_item.zig").ScheduleItem;

/// Defines an installment-based pricing model where customers are charged a
/// fixed price on different dates during the agreement validity period. This is
/// used most commonly for flexible payment schedule pricing.
pub const PaymentScheduleTerm = struct {
    /// Defines the currency for the prices mentioned in the term.
    currency_code: ?[]const u8,

    /// List of the payment schedule where each element defines one installment of
    /// payment. It contains the information necessary for calculating the price.
    schedule: ?[]const ScheduleItem,

    /// Type of the term.
    type: ?[]const u8,

    pub const json_field_names = .{
        .currency_code = "currencyCode",
        .schedule = "schedule",
        .type = "type",
    };
};
