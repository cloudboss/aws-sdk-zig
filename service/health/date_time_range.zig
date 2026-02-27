/// A range of dates and times that is used by the
/// [EventFilter](https://docs.aws.amazon.com/health/latest/APIReference/API_EventFilter.html) and [EntityFilter](https://docs.aws.amazon.com/health/latest/APIReference/API_EntityFilter.html) objects. If `from` is set and `to` is set:
/// match items where the timestamp (`startTime`, `endTime`, or
/// `lastUpdatedTime`) is between `from` and `to`
/// inclusive. If `from` is set and `to` is not set: match items where
/// the timestamp value is equal to or after `from`. If `from` is not set
/// and `to` is set: match items where the timestamp value is equal to or before
/// `to`.
pub const DateTimeRange = struct {
    /// The starting date and time of a time range.
    from: ?i64,

    /// The ending date and time of a time range.
    to: ?i64,

    pub const json_field_names = .{
        .from = "from",
        .to = "to",
    };
};
