/// Specifies the starting point in a Kinesis stream to start processing. You
/// can use the
/// producer timestamp or the fragment number. One of either producer timestamp
/// or fragment
/// number is required. If you use the producer timestamp, you must put the time
/// in
/// milliseconds. For more information about fragment numbers, see
/// [Fragment](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/API_reader_Fragment.html).
pub const KinesisVideoStreamStartSelector = struct {
    /// The unique identifier of the fragment. This value monotonically increases
    /// based on the ingestion order.
    fragment_number: ?[]const u8,

    /// The timestamp from the producer corresponding to the fragment, in
    /// milliseconds,
    /// expressed in unix time format.
    producer_timestamp: ?i64,

    pub const json_field_names = .{
        .fragment_number = "FragmentNumber",
        .producer_timestamp = "ProducerTimestamp",
    };
};
