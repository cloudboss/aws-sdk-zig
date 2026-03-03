/// The predicted high and low fault count. This is used to determine if a
/// service has
/// become anomalous and if an insight should be created.
pub const ForecastStatistics = struct {
    /// The upper limit of fault counts for a service.
    fault_count_high: ?i64 = null,

    /// The lower limit of fault counts for a service.
    fault_count_low: ?i64 = null,

    pub const json_field_names = .{
        .fault_count_high = "FaultCountHigh",
        .fault_count_low = "FaultCountLow",
    };
};
