pub const NotificationConfigurationSubtype = enum {
    /// Notification configuration created by the account
    account,
    /// Notification configuration managed by an administrator account
    admin_managed,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .admin_managed = "ADMIN_MANAGED",
    };
};
