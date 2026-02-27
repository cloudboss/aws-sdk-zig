pub const UpdateRecommendationLifecycleStageReasonCode = enum {
    non_critical_account,
    temporary_account,
    valid_business_case,
    other_methods_available,
    low_priority,
    not_applicable,
    other,

    pub const json_field_names = .{
        .non_critical_account = "NON_CRITICAL_ACCOUNT",
        .temporary_account = "TEMPORARY_ACCOUNT",
        .valid_business_case = "VALID_BUSINESS_CASE",
        .other_methods_available = "OTHER_METHODS_AVAILABLE",
        .low_priority = "LOW_PRIORITY",
        .not_applicable = "NOT_APPLICABLE",
        .other = "OTHER",
    };
};
