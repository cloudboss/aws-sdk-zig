pub const MessageFeedbackStatus = enum {
    received,
    failed,

    pub const json_field_names = .{
        .received = "RECEIVED",
        .failed = "FAILED",
    };
};
