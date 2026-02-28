const SearchContactsTimeRangeConditionType = @import("search_contacts_time_range_condition_type.zig").SearchContactsTimeRangeConditionType;
const SearchContactsTimeRangeType = @import("search_contacts_time_range_type.zig").SearchContactsTimeRangeType;

/// The timestamp condition indicating which contact timestamp should be used
/// and how it should be filtered. It is
/// not an actual timestamp value.
pub const SearchContactsTimestampCondition = struct {
    /// Condition of the timestamp on the contact.
    condition_type: SearchContactsTimeRangeConditionType,

    /// Type of the timestamps to use for the filter.
    type: SearchContactsTimeRangeType,

    pub const json_field_names = .{
        .condition_type = "ConditionType",
        .type = "Type",
    };
};
