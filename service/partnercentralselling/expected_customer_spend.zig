const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const PaymentFrequency = @import("payment_frequency.zig").PaymentFrequency;

/// Provides an estimate of the revenue that the partner is expected to generate
/// from the opportunity. This information helps partners assess the financial
/// value of the project.
pub const ExpectedCustomerSpend = struct {
    /// Represents the estimated monthly revenue that the partner expects to earn
    /// from the opportunity. This helps in forecasting financial returns.
    amount: []const u8 = "",

    /// Indicates the currency in which the revenue estimate is provided. This helps
    /// in understanding the financial impact across different markets. Accepted
    /// values are `USD` (US Dollars) and `EUR` (Euros). If the AWS Partition is
    /// `aws-eusc` (AWS European Sovereign Cloud), the currency code must be `EUR`.
    currency_code: CurrencyCode,

    /// A URL providing additional information or context about the spend
    /// estimation.
    estimation_url: ?[]const u8 = null,

    /// Indicates how frequently the customer is expected to spend the projected
    /// amount. Use `Monthly` for recurring monthly spend (required for
    /// `TargetCompany: "AWS"` entries). Use `None` for one-time deal value entries
    /// (required for `TargetCompany: "Self"` entries when providing Total Contract
    /// Value).
    frequency: PaymentFrequency,

    /// Specifies the entity associated with this spend entry. Use `AWS` for the
    /// system’s AWS Monthly Recurring Revenue (MRR) estimate. Use `Self` for the
    /// partner’s own deal value entry when providing Total Contract Value (TCV) for
    /// automatic MRR conversion. When `ExpectedContractDuration` is present on the
    /// Project, only `AWS` and `Self` are accepted. When `ExpectedContractDuration`
    /// is not present, only `AWS` is accepted and any other value will be
    /// automatically set to `AWS`.
    target_company: []const u8,

    pub const json_field_names = .{
        .amount = "Amount",
        .currency_code = "CurrencyCode",
        .estimation_url = "EstimationUrl",
        .frequency = "Frequency",
        .target_company = "TargetCompany",
    };
};
