/// Configuration parameters specific to VPC Flow Logs.
pub const VPCFlowLogParameters = struct {
    /// The format in which VPC Flow Log entries should be logged.
    log_format: ?[]const u8 = null,

    /// The maximum interval in seconds between the capture of flow log records.
    max_aggregation_interval: ?i32 = null,

    /// The type of traffic to log (ACCEPT, REJECT, or ALL).
    traffic_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_format = "LogFormat",
        .max_aggregation_interval = "MaxAggregationInterval",
        .traffic_type = "TrafficType",
    };
};
