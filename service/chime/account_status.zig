pub const AccountStatus = enum {
    suspended,
    active,

    pub const json_field_names = .{
        .suspended = "Suspended",
        .active = "Active",
    };
};
