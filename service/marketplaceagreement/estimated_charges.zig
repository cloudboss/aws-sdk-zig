/// Estimated cost of the agreement.
pub const EstimatedCharges = struct {
    /// The total known amount customer has to pay across the lifecycle of the
    /// agreement.
    ///
    /// This is the total contract value if accepted terms contain
    /// `ConfigurableUpfrontPricingTerm` or `FixedUpfrontPricingTerm`. In the case
    /// of pure contract pricing, this will be the total value of the contract. In
    /// the case of contracts with consumption pricing, this will only include the
    /// committed value and not include any overages that occur.
    ///
    /// If the accepted terms contain `PaymentScheduleTerm`, it will be the total
    /// payment schedule amount. This occurs when flexible payment schedule is used,
    /// and is the sum of all invoice charges in the payment schedule.
    ///
    /// In case a customer has amended an agreement, by purchasing more units of any
    /// dimension, this will include both the original cost as well as the added
    /// cost incurred due to addition of new units.
    ///
    /// This is `0` if the accepted terms contain `UsageBasedPricingTerm` without
    /// `ConfigurableUpfrontPricingTerm` or `RecurringPaymentTerm`. This occurs for
    /// usage-based pricing (such as SaaS metered or AMI/container hourly or
    /// monthly), because the exact usage is not known upfront.
    agreement_value: ?[]const u8,

    /// Defines the currency code for the charge.
    currency_code: ?[]const u8,

    pub const json_field_names = .{
        .agreement_value = "agreementValue",
        .currency_code = "currencyCode",
    };
};
