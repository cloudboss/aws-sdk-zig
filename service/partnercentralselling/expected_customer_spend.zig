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
    /// in understanding the financial impact across different markets.
    currency_code: CurrencyCode,

    /// A URL providing additional information or context about the spend
    /// estimation.
    estimation_url: ?[]const u8 = null,

    /// Indicates how frequently the customer is expected to spend the projected
    /// amount. Only the value `Monthly` is allowed for the `Frequency` field,
    /// representing recurring monthly spend.
    frequency: PaymentFrequency,

    /// Specifies the name of the partner company that is expected to generate
    /// revenue from the opportunity. This field helps track the partner’s
    /// involvement in the opportunity. This field only accepts the value `AWS`. If
    /// any other value is provided, the system will automatically set it to `AWS`.
    target_company: []const u8,

    pub const json_field_names = .{
        .amount = "Amount",
        .currency_code = "CurrencyCode",
        .estimation_url = "EstimationUrl",
        .frequency = "Frequency",
        .target_company = "TargetCompany",
    };
};
