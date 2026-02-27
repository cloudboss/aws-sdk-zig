pub const Origin = enum {
    system,
    customer,

    pub const json_field_names = .{
        .system = "SYSTEM",
        .customer = "CUSTOMER",
    };
};
