const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const SavingsPlanPaymentOption = @import("savings_plan_payment_option.zig").SavingsPlanPaymentOption;
const SavingsPlanType = @import("savings_plan_type.zig").SavingsPlanType;

/// Information about a Savings Plan offering.
pub const ParentSavingsPlanOffering = struct {
    /// The currency.
    currency: ?CurrencyCode = null,

    /// The duration, in seconds.
    duration_seconds: i64 = 0,

    /// The ID of the offering.
    offering_id: ?[]const u8 = null,

    /// The payment option.
    payment_option: ?SavingsPlanPaymentOption = null,

    /// The description.
    plan_description: ?[]const u8 = null,

    /// The plan type.
    plan_type: ?SavingsPlanType = null,

    pub const json_field_names = .{
        .currency = "currency",
        .duration_seconds = "durationSeconds",
        .offering_id = "offeringId",
        .payment_option = "paymentOption",
        .plan_description = "planDescription",
        .plan_type = "planType",
    };
};
