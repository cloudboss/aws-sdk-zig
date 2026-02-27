pub const LabelDetectionAggregateBy = enum {
    timestamps,
    segments,

    pub const json_field_names = .{
        .timestamps = "TIMESTAMPS",
        .segments = "SEGMENTS",
    };
};
