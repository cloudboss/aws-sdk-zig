pub const GroupingRecommendationRejectionReason = enum {
    distinct_business_purpose,
    separate_data_concern,
    distinct_user_group_handling,
    other,

    pub const json_field_names = .{
        .distinct_business_purpose = "DISTINCT_BUSINESS_PURPOSE",
        .separate_data_concern = "SEPARATE_DATA_CONCERN",
        .distinct_user_group_handling = "DISTINCT_USER_GROUP_HANDLING",
        .other = "OTHER",
    };
};
