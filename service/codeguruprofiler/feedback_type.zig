pub const FeedbackType = enum {
    /// Profiler recommendation flagged as useful.
    positive,
    /// Profiler recommendation flagged as not useful.
    negative,

    pub const json_field_names = .{
        .positive = "Positive",
        .negative = "Negative",
    };
};
