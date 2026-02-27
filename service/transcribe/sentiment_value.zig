pub const SentimentValue = enum {
    positive,
    negative,
    neutral,
    mixed,

    pub const json_field_names = .{
        .positive = "POSITIVE",
        .negative = "NEGATIVE",
        .neutral = "NEUTRAL",
        .mixed = "MIXED",
    };
};
