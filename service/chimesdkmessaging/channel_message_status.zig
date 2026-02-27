pub const ChannelMessageStatus = enum {
    sent,
    pending,
    failed,
    denied,

    pub const json_field_names = .{
        .sent = "SENT",
        .pending = "PENDING",
        .failed = "FAILED",
        .denied = "DENIED",
    };
};
