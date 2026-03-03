/// Describes the buffering to perform before delivering data to the Snowflake
/// destination. If you do not specify any value, Firehose uses the default
/// values.
pub const SnowflakeBufferingHints = struct {
    /// Buffer incoming data for the specified period of time, in seconds, before
    /// delivering it to the destination. The default value is 0.
    interval_in_seconds: ?i32 = null,

    /// Buffer incoming data to the specified size, in MBs, before delivering it to
    /// the
    /// destination. The default value is 128.
    size_in_m_bs: ?i32 = null,

    pub const json_field_names = .{
        .interval_in_seconds = "IntervalInSeconds",
        .size_in_m_bs = "SizeInMBs",
    };
};
