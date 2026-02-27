pub const DomainStatus = enum {
    active,
    pending,
    suspended,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .pending = "PENDING",
        .suspended = "SUSPENDED",
    };
};
