pub const CisScanResultsAggregatedByTargetResourceSortBy = enum {
    resource_id,
    failed_counts,
    account_id,
    platform,
    target_status,
    target_status_reason,

    pub const json_field_names = .{
        .resource_id = "RESOURCE_ID",
        .failed_counts = "FAILED_COUNTS",
        .account_id = "ACCOUNT_ID",
        .platform = "PLATFORM",
        .target_status = "TARGET_STATUS",
        .target_status_reason = "TARGET_STATUS_REASON",
    };
};
