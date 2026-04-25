const CurrencyCode = @import("currency_code.zig").CurrencyCode;

/// Specifies payments details.
pub const MonetaryValue = struct {
    /// Specifies the payment amount.
    amount: []const u8,

    /// Specifies the payment currency. Accepted values are `USD` (US Dollars) and
    /// `EUR` (Euros). If the AWS Partition is `aws-eusc` (AWS European Sovereign
    /// Cloud), the currency code must be `EUR`.
    currency_code: CurrencyCode,

    pub const json_field_names = .{
        .amount = "Amount",
        .currency_code = "CurrencyCode",
    };
};
