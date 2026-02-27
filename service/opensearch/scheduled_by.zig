pub const ScheduledBy = enum {
    customer,
    system,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .system = "SYSTEM",
    };
};
