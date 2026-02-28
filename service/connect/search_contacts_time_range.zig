const SearchContactsTimeRangeType = @import("search_contacts_time_range_type.zig").SearchContactsTimeRangeType;

/// A structure of time range that you want to search results.
pub const SearchContactsTimeRange = struct {
    /// The end time of the time range.
    end_time: i64,

    /// The start time of the time range.
    start_time: i64,

    /// The type of timestamp to search.
    @"type": SearchContactsTimeRangeType,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
        .@"type" = "Type",
    };
};
