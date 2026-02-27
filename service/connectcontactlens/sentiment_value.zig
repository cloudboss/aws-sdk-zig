pub const SentimentValue = enum {
    positive,
    neutral,
    negative,

    pub const json_field_names = .{
        .positive = "POSITIVE",
        .neutral = "NEUTRAL",
        .negative = "NEGATIVE",
    };
};
