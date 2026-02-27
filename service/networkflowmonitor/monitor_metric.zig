pub const MonitorMetric = enum {
    round_trip_time,
    timeouts,
    retransmissions,
    data_transferred,

    pub const json_field_names = .{
        .round_trip_time = "ROUND_TRIP_TIME",
        .timeouts = "TIMEOUTS",
        .retransmissions = "RETRANSMISSIONS",
        .data_transferred = "DATA_TRANSFERRED",
    };
};
