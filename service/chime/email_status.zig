pub const EmailStatus = enum {
    not_sent,
    sent,
    failed,

    pub const json_field_names = .{
        .not_sent = "NotSent",
        .sent = "Sent",
        .failed = "Failed",
    };
};
