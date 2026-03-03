const SearchContactsTimeRange = @import("search_contacts_time_range.zig").SearchContactsTimeRange;
const SearchContactsTimestampCondition = @import("search_contacts_timestamp_condition.zig").SearchContactsTimestampCondition;

/// The criteria of the time range to additionally filter on.
pub const SearchContactsAdditionalTimeRangeCriteria = struct {
    time_range: ?SearchContactsTimeRange = null,

    /// List of the timestamp conditions.
    timestamp_condition: ?SearchContactsTimestampCondition = null,

    pub const json_field_names = .{
        .time_range = "TimeRange",
        .timestamp_condition = "TimestampCondition",
    };
};
