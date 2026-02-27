pub const SelfUpgradeStatus = enum {
    auto_approval,
    admin_approval,

    pub const json_field_names = .{
        .auto_approval = "AUTO_APPROVAL",
        .admin_approval = "ADMIN_APPROVAL",
    };
};
