const CryptoCurrency = @import("crypto_currency.zig").CryptoCurrency;

/// The price per request for a payment network, specifying the amount and
/// cryptocurrency.
pub const Price = struct {
    /// The price per request as a decimal string in the specified currency.
    /// Minimum: 0.001. Maximum: 999999999.999. Supports up to 3 decimal places.
    amount: []const u8,

    /// The cryptocurrency for payment. Currently only `USDC` is supported.
    currency: CryptoCurrency,

    pub const json_field_names = .{
        .amount = "Amount",
        .currency = "Currency",
    };
};
