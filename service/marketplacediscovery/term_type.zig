const std = @import("std");

pub const TermType = enum {
    byol_pricing_term,
    configurable_upfront_pricing_term,
    fixed_upfront_pricing_term,
    usage_based_pricing_term,
    free_trial_pricing_term,
    legal_term,
    payment_schedule_term,
    recurring_payment_term,
    renewal_term,
    support_term,
    validity_term,
    variable_payment_term,
    net_payment_term,

    pub const json_field_names = .{
        .byol_pricing_term = "ByolPricingTerm",
        .configurable_upfront_pricing_term = "ConfigurableUpfrontPricingTerm",
        .fixed_upfront_pricing_term = "FixedUpfrontPricingTerm",
        .usage_based_pricing_term = "UsageBasedPricingTerm",
        .free_trial_pricing_term = "FreeTrialPricingTerm",
        .legal_term = "LegalTerm",
        .payment_schedule_term = "PaymentScheduleTerm",
        .recurring_payment_term = "RecurringPaymentTerm",
        .renewal_term = "RenewalTerm",
        .support_term = "SupportTerm",
        .validity_term = "ValidityTerm",
        .variable_payment_term = "VariablePaymentTerm",
        .net_payment_term = "NetPaymentTerm",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .byol_pricing_term => "ByolPricingTerm",
            .configurable_upfront_pricing_term => "ConfigurableUpfrontPricingTerm",
            .fixed_upfront_pricing_term => "FixedUpfrontPricingTerm",
            .usage_based_pricing_term => "UsageBasedPricingTerm",
            .free_trial_pricing_term => "FreeTrialPricingTerm",
            .legal_term => "LegalTerm",
            .payment_schedule_term => "PaymentScheduleTerm",
            .recurring_payment_term => "RecurringPaymentTerm",
            .renewal_term => "RenewalTerm",
            .support_term => "SupportTerm",
            .validity_term => "ValidityTerm",
            .variable_payment_term => "VariablePaymentTerm",
            .net_payment_term => "NetPaymentTerm",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
