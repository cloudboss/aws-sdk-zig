/// Configuration for sliding window truncation strategy.
pub const HarnessSlidingWindowConfiguration = struct {
    /// The number of recent messages to retain in the context window.
    messages_count: ?i32 = null,

    pub const json_field_names = .{
        .messages_count = "messagesCount",
    };
};
