/// Trigger configuration based on tokens.
pub const TokenBasedTrigger = struct {
    /// Number of tokens that trigger memory processing.
    token_count: ?i32 = null,

    pub const json_field_names = .{
        .token_count = "tokenCount",
    };
};
