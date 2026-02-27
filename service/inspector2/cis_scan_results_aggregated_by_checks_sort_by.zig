pub const CisScanResultsAggregatedByChecksSortBy = enum {
    check_id,
    title,
    platform,
    failed_counts,
    security_level,

    pub const json_field_names = .{
        .check_id = "CHECK_ID",
        .title = "TITLE",
        .platform = "PLATFORM",
        .failed_counts = "FAILED_COUNTS",
        .security_level = "SECURITY_LEVEL",
    };
};
