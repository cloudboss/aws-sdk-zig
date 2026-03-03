/// Statistics that describe how the incident has impacted a service.
pub const RequestImpactStatistics = struct {
    /// The number of requests that have resulted in a fault,
    fault_count: ?i64 = null,

    /// The number of successful requests.
    ok_count: ?i64 = null,

    /// The total number of requests to the service.
    total_count: ?i64 = null,

    pub const json_field_names = .{
        .fault_count = "FaultCount",
        .ok_count = "OkCount",
        .total_count = "TotalCount",
    };
};
