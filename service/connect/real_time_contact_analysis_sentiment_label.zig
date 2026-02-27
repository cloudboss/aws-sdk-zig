pub const RealTimeContactAnalysisSentimentLabel = enum {
    positive,
    negative,
    neutral,

    pub const json_field_names = .{
        .positive = "POSITIVE",
        .negative = "NEGATIVE",
        .neutral = "NEUTRAL",
    };
};
