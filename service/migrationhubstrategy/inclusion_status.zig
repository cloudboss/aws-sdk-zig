pub const InclusionStatus = enum {
    exclude_from_recommendation,
    include_in_recommendation,

    pub const json_field_names = .{
        .exclude_from_recommendation = "EXCLUDE_FROM_RECOMMENDATION",
        .include_in_recommendation = "INCLUDE_IN_RECOMMENDATION",
    };
};
