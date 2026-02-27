/// The buffering options. If no value is specified, the default values for
/// Splunk are used.
pub const SplunkBufferingHints = struct {
    /// Buffer incoming data for the specified period of time, in seconds, before
    /// delivering it to the destination. The default value is 60 (1 minute).
    interval_in_seconds: ?i32,

    /// Buffer incoming data to the specified size, in MBs, before delivering it to
    /// the destination. The default value is 5.
    size_in_m_bs: ?i32,

    pub const json_field_names = .{
        .interval_in_seconds = "IntervalInSeconds",
        .size_in_m_bs = "SizeInMBs",
    };
};
