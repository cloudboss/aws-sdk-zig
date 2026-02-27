pub const AuditNotificationType = enum {
    sns,

    pub const json_field_names = .{
        .sns = "SNS",
    };
};
