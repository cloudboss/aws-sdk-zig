const SearchContactsAdditionalTimeRangeCriteria = @import("search_contacts_additional_time_range_criteria.zig").SearchContactsAdditionalTimeRangeCriteria;
const SearchContactsMatchType = @import("search_contacts_match_type.zig").SearchContactsMatchType;

/// Time range that you **additionally** want to filter on.
///
/// This is different from the
/// [SearchContactsTimeRange](https://docs.aws.amazon.com/connect/latest/APIReference/API_SearchContactsTimeRange.html) data
/// type.
pub const SearchContactsAdditionalTimeRange = struct {
    /// List of criteria of the time range to additionally filter on.
    criteria: []const SearchContactsAdditionalTimeRangeCriteria,

    /// The match type combining multiple time range filters.
    match_type: SearchContactsMatchType,

    pub const json_field_names = .{
        .criteria = "Criteria",
        .match_type = "MatchType",
    };
};
