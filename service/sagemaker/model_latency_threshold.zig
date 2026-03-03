/// The model latency threshold.
pub const ModelLatencyThreshold = struct {
    /// The model latency percentile threshold. Acceptable values are `P95` and
    /// `P99`. For custom load tests, specify the value as `P95`.
    percentile: ?[]const u8 = null,

    /// The model latency percentile value in milliseconds.
    value_in_milliseconds: ?i32 = null,

    pub const json_field_names = .{
        .percentile = "Percentile",
        .value_in_milliseconds = "ValueInMilliseconds",
    };
};
