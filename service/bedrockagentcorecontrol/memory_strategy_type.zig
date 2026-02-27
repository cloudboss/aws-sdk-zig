pub const MemoryStrategyType = enum {
    semantic,
    summarization,
    user_preference,
    custom,
    episodic,

    pub const json_field_names = .{
        .semantic = "SEMANTIC",
        .summarization = "SUMMARIZATION",
        .user_preference = "USER_PREFERENCE",
        .custom = "CUSTOM",
        .episodic = "EPISODIC",
    };
};
