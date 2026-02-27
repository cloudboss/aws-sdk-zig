pub const ConversationStatusReason = enum {
    success,
    failed,
    rejected,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .failed = "FAILED",
        .rejected = "REJECTED",
    };
};
