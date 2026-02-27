pub const RenewType = enum {
    none,
    weekly,
    monthly,

    pub const json_field_names = .{
        .none = "NONE",
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
    };
};
