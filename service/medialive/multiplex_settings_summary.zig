/// Contains summary configuration for a Multiplex event.
pub const MultiplexSettingsSummary = struct {
    /// Transport stream bit rate.
    transport_stream_bitrate: ?i32 = null,

    pub const json_field_names = .{
        .transport_stream_bitrate = "TransportStreamBitrate",
    };
};
