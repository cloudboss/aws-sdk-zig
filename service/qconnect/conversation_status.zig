pub const ConversationStatus = enum {
    closed,
    ready,
    processing,

    pub const json_field_names = .{
        .closed = "CLOSED",
        .ready = "READY",
        .processing = "PROCESSING",
    };
};
