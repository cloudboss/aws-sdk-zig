/// Describes hints for the buffering to perform before delivering data to the
/// destination. These options are treated as hints, and therefore Firehose
/// might
/// choose to use different values when it is optimal. The `SizeInMBs` and
/// `IntervalInSeconds` parameters are optional. However, if specify a value for
/// one of them, you must also provide a value for the other.
pub const BufferingHints = struct {
    /// Buffer incoming data for the specified period of time, in seconds, before
    /// delivering
    /// it to the destination. The default value is 300. This parameter is optional
    /// but if you
    /// specify a value for it, you must also specify a value for `SizeInMBs`, and
    /// vice
    /// versa.
    interval_in_seconds: ?i32 = null,

    /// Buffer incoming data to the specified size, in MiBs, before delivering it to
    /// the
    /// destination. The default value is 5. This parameter is optional but if you
    /// specify a value
    /// for it, you must also specify a value for `IntervalInSeconds`, and vice
    /// versa.
    ///
    /// We recommend setting this parameter to a value greater than the amount of
    /// data you
    /// typically ingest into the Firehose stream in 10 seconds. For example, if you
    /// typically
    /// ingest data at 1 MiB/sec, the value should be 10 MiB or higher.
    size_in_m_bs: ?i32 = null,

    pub const json_field_names = .{
        .interval_in_seconds = "IntervalInSeconds",
        .size_in_m_bs = "SizeInMBs",
    };
};
