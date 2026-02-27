pub const ListCisScansSortBy = enum {
    status,
    scheduled_by,
    scan_start_date,
    failed_checks,

    pub const json_field_names = .{
        .status = "STATUS",
        .scheduled_by = "SCHEDULED_BY",
        .scan_start_date = "SCAN_START_DATE",
        .failed_checks = "FAILED_CHECKS",
    };
};
