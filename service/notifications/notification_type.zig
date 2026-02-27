pub const NotificationType = enum {
    alert,
    warning,
    announcement,
    informational,

    pub const json_field_names = .{
        .alert = "ALERT",
        .warning = "WARNING",
        .announcement = "ANNOUNCEMENT",
        .informational = "INFORMATIONAL",
    };
};
