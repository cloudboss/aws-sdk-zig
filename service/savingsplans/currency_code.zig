pub const CurrencyCode = enum {
    cny,
    usd,
    eur,

    pub const json_field_names = .{
        .cny = "CNY",
        .usd = "USD",
        .eur = "EUR",
    };
};
