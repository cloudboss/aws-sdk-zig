pub const PaymentFrequency = enum {
    monthly,

    pub const json_field_names = .{
        .monthly = "MONTHLY",
    };
};
