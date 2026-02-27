pub const Sentiment = enum {
    positive,
    negative,
    mixed,
    neutral,

    pub const json_field_names = .{
        .positive = "POSITIVE",
        .negative = "NEGATIVE",
        .mixed = "MIXED",
        .neutral = "NEUTRAL",
    };
};
