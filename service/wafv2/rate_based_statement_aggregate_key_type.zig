pub const RateBasedStatementAggregateKeyType = enum {
    ip,
    forwarded_ip,
    custom_keys,
    constant,

    pub const json_field_names = .{
        .ip = "IP",
        .forwarded_ip = "FORWARDED_IP",
        .custom_keys = "CUSTOM_KEYS",
        .constant = "CONSTANT",
    };
};
