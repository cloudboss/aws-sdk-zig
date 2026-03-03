/// Describes the buffering to perform before delivering data to the Amazon
/// OpenSearch
/// Service destination.
pub const AmazonopensearchserviceBufferingHints = struct {
    /// Buffer incoming data for the specified period of time, in seconds, before
    /// delivering it
    /// to the destination. The default value is 300 (5 minutes).
    interval_in_seconds: ?i32 = null,

    /// Buffer incoming data to the specified size, in MBs, before delivering it to
    /// the
    /// destination. The default value is 5.
    ///
    /// We recommend setting this parameter to a value greater than the amount of
    /// data you
    /// typically ingest into the Firehose stream in 10 seconds. For example, if you
    /// typically
    /// ingest data at 1 MB/sec, the value should be 10 MB or higher.
    size_in_m_bs: ?i32 = null,

    pub const json_field_names = .{
        .interval_in_seconds = "IntervalInSeconds",
        .size_in_m_bs = "SizeInMBs",
    };
};
