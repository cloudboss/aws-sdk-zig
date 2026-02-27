pub const PendingAction = enum {
    customer,
    none,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .none = "NONE",
    };
};
