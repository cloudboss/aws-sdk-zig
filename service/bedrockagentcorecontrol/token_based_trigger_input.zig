/// Trigger configuration based on tokens.
pub const TokenBasedTriggerInput = struct {
    /// Number of tokens that trigger memory processing.
    token_count: i32 = 5000,

    pub const json_field_names = .{
        .token_count = "tokenCount",
    };
};
