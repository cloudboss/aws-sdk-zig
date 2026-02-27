pub const ChannelLatencyMode = enum {
    normal_latency,
    low_latency,

    pub const json_field_names = .{
        .normal_latency = "NormalLatency",
        .low_latency = "LowLatency",
    };
};
