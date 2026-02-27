pub const UserStatusType = enum {
    active,
    inactive,
    pending,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .pending = "PENDING",
    };
};
