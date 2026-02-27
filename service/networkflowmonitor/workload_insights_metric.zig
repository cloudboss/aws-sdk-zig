pub const WorkloadInsightsMetric = enum {
    timeouts,
    retransmissions,
    data_transferred,

    pub const json_field_names = .{
        .timeouts = "TIMEOUTS",
        .retransmissions = "RETRANSMISSIONS",
        .data_transferred = "DATA_TRANSFERRED",
    };
};
