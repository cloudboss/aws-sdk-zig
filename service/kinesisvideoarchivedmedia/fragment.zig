/// Represents a segment of video or other time-delimited data.
pub const Fragment = struct {
    /// The playback duration or other time value associated with the fragment.
    fragment_length_in_milliseconds: i64 = 0,

    /// The unique identifier of the fragment. This value monotonically increases
    /// based on the
    /// ingestion order.
    fragment_number: ?[]const u8 = null,

    /// The total fragment size, including information about the fragment and
    /// contained media
    /// data.
    fragment_size_in_bytes: i64 = 0,

    /// The timestamp from the producer corresponding to the fragment.
    producer_timestamp: ?i64 = null,

    /// The timestamp from the Amazon Web Services server corresponding to the
    /// fragment.
    server_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .fragment_length_in_milliseconds = "FragmentLengthInMilliseconds",
        .fragment_number = "FragmentNumber",
        .fragment_size_in_bytes = "FragmentSizeInBytes",
        .producer_timestamp = "ProducerTimestamp",
        .server_timestamp = "ServerTimestamp",
    };
};
