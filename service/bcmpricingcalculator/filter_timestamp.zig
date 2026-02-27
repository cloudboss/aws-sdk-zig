/// Represents a time-based filter.
pub const FilterTimestamp = struct {
    /// Include results after this timestamp.
    after_timestamp: ?i64,

    /// Include results before this timestamp.
    before_timestamp: ?i64,

    pub const json_field_names = .{
        .after_timestamp = "afterTimestamp",
        .before_timestamp = "beforeTimestamp",
    };
};
