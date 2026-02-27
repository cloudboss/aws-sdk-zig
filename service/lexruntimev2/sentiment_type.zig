pub const SentimentType = enum {
    mixed,
    negative,
    neutral,
    positive,

    pub const json_field_names = .{
        .mixed = "MIXED",
        .negative = "NEGATIVE",
        .neutral = "NEUTRAL",
        .positive = "POSITIVE",
    };
};
