pub const CheckoutType = enum {
    provisional,
    perpetual,

    pub const json_field_names = .{
        .provisional = "PROVISIONAL",
        .perpetual = "PERPETUAL",
    };
};
