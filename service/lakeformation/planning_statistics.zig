/// Statistics related to the processing of a query statement.
pub const PlanningStatistics = struct {
    /// An estimate of the data that was scanned in bytes.
    estimated_data_to_scan_bytes: i64 = 0,

    /// The time that it took to process the request.
    planning_time_millis: i64 = 0,

    /// The time the request was in queue to be processed.
    queue_time_millis: i64 = 0,

    /// The number of work units generated.
    work_units_generated_count: i64 = 0,

    pub const json_field_names = .{
        .estimated_data_to_scan_bytes = "EstimatedDataToScanBytes",
        .planning_time_millis = "PlanningTimeMillis",
        .queue_time_millis = "QueueTimeMillis",
        .work_units_generated_count = "WorkUnitsGeneratedCount",
    };
};
