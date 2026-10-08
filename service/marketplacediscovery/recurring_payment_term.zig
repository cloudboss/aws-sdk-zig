const BillingPeriodType = @import("billing_period_type.zig").BillingPeriodType;
const TermType = @import("term_type.zig").TermType;

/// Defines a recurring payment term with fixed charges at regular billing
/// intervals.
pub const RecurringPaymentTerm = struct {
    /// The billing period frequency, such as `Monthly`.
    billing_period: BillingPeriodType,

    /// Defines the currency for the prices in this term.
    currency_code: []const u8,

    /// The unique identifier of the term.
    id: []const u8,

    /// The amount charged each billing period.
    price: []const u8,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .billing_period = "billingPeriod",
        .currency_code = "currencyCode",
        .id = "id",
        .price = "price",
        .type = "type",
    };
};
