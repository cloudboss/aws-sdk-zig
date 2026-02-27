/// A timestamp filter.
pub const TimestampFilter = struct {
    /// The timestamp after which statistics should be included in the results.
    recorded_after: ?i64,

    /// The timestamp before which statistics should be included in the results.
    recorded_before: ?i64,

    pub const json_field_names = .{
        .recorded_after = "RecordedAfter",
        .recorded_before = "RecordedBefore",
    };
};
