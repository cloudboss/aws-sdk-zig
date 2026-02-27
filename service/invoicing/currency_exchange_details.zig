/// The details of currency exchange.
pub const CurrencyExchangeDetails = struct {
    /// The currency exchange rate.
    rate: ?[]const u8,

    /// The exchange source currency.
    source_currency_code: ?[]const u8,

    /// The exchange target currency.
    target_currency_code: ?[]const u8,

    pub const json_field_names = .{
        .rate = "Rate",
        .source_currency_code = "SourceCurrencyCode",
        .target_currency_code = "TargetCurrencyCode",
    };
};
