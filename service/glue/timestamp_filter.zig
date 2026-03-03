/// A timestamp filter.
pub const TimestampFilter = struct {
    /// The timestamp after which statistics should be included in the results.
    recorded_after: ?i64 = null,

    /// The timestamp before which statistics should be included in the results.
    recorded_before: ?i64 = null,

    pub const json_field_names = .{
        .recorded_after = "RecordedAfter",
        .recorded_before = "RecordedBefore",
    };
};
