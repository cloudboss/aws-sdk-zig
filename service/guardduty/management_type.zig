pub const ManagementType = enum {
    auto_managed,
    manual,
    disabled,

    pub const json_field_names = .{
        .auto_managed = "AUTO_MANAGED",
        .manual = "MANUAL",
        .disabled = "DISABLED",
    };
};
