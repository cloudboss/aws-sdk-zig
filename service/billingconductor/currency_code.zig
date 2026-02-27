pub const CurrencyCode = enum {
    usd,
    cny,

    pub const json_field_names = .{
        .usd = "USD",
        .cny = "CNY",
    };
};
