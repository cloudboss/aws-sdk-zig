/// The CIS date filter.
pub const CisDateFilter = struct {
    /// The CIS date filter's earliest scan start time.
    earliest_scan_start_time: ?i64 = null,

    /// The CIS date filter's latest scan start time.
    latest_scan_start_time: ?i64 = null,

    pub const json_field_names = .{
        .earliest_scan_start_time = "earliestScanStartTime",
        .latest_scan_start_time = "latestScanStartTime",
    };
};
