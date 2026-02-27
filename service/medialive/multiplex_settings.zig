/// Contains configuration for a Multiplex event
pub const MultiplexSettings = struct {
    /// Maximum video buffer delay in milliseconds.
    maximum_video_buffer_delay_milliseconds: ?i32,

    /// Transport stream bit rate.
    transport_stream_bitrate: i32,

    /// Transport stream ID.
    transport_stream_id: i32,

    /// Transport stream reserved bit rate.
    transport_stream_reserved_bitrate: ?i32,

    pub const json_field_names = .{
        .maximum_video_buffer_delay_milliseconds = "MaximumVideoBufferDelayMilliseconds",
        .transport_stream_bitrate = "TransportStreamBitrate",
        .transport_stream_id = "TransportStreamId",
        .transport_stream_reserved_bitrate = "TransportStreamReservedBitrate",
    };
};
