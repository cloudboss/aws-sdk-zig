const PaymentOption = @import("payment_option.zig").PaymentOption;
const PaymentTerm = @import("payment_term.zig").PaymentTerm;

/// The pricing details for a subscription.
pub const SubscriptionPricingDetails = struct {
    /// The monthly recurring price.
    monthly_recurring_price: ?f32 = null,

    /// The payment option.
    payment_option: ?PaymentOption = null,

    /// The payment term.
    payment_term: ?PaymentTerm = null,

    /// The upfront price.
    upfront_price: ?f32 = null,

    pub const json_field_names = .{
        .monthly_recurring_price = "MonthlyRecurringPrice",
        .payment_option = "PaymentOption",
        .payment_term = "PaymentTerm",
        .upfront_price = "UpfrontPrice",
    };
};
