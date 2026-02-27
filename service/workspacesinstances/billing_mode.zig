pub const BillingMode = enum {
    monthly,
    hourly,

    pub const json_field_names = .{
        .monthly = "MONTHLY",
        .hourly = "HOURLY",
    };
};
