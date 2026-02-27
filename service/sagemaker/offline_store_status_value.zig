pub const OfflineStoreStatusValue = enum {
    active,
    blocked,
    disabled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .blocked = "BLOCKED",
        .disabled = "DISABLED",
    };
};
