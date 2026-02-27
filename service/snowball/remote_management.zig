pub const RemoteManagement = enum {
    installed_only,
    installed_autostart,
    not_installed,

    pub const json_field_names = .{
        .installed_only = "INSTALLED_ONLY",
        .installed_autostart = "INSTALLED_AUTOSTART",
        .not_installed = "NOT_INSTALLED",
    };
};
