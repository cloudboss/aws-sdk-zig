const NdiSourceSettings = @import("ndi_source_settings.zig").NdiSourceSettings;
const Protocol = @import("protocol.zig").Protocol;

/// Attributes related to the transport stream that are used in a source or
/// output.
pub const Transport = struct {
    /// The range of IP addresses that should be allowed to initiate output requests
    /// to this flow. These IP addresses should be in the form of a Classless
    /// Inter-Domain Routing (CIDR) block; for example, 10.0.0.0/16
    cidr_allow_list: ?[]const []const u8 = null,

    /// The smoothing max bitrate (in bps) for RIST, RTP, and RTP-FEC streams.
    max_bitrate: ?i32 = null,

    /// The maximum latency in milliseconds. This parameter applies only to
    /// RIST-based and Zixi-based streams.
    max_latency: ?i32 = null,

    /// The size of the buffer (in milliseconds) to use to sync incoming source
    /// data.
    max_sync_buffer: ?i32 = null,

    /// The minimum latency in milliseconds for SRT-based streams. In streams that
    /// use the SRT protocol, this value that you set on your MediaConnect source or
    /// output represents the minimal potential latency of that connection. The
    /// latency of the stream is set to the highest number between the sender’s
    /// minimum latency and the receiver’s minimum latency.
    min_latency: ?i32 = null,

    /// A suffix for the name of the NDI® sender that the flow creates. If a custom
    /// name isn't specified, MediaConnect uses the output name.
    ndi_program_name: ?[]const u8 = null,

    /// The settings for the NDI source. This includes the exact name of the
    /// upstream NDI sender that you want to connect to your source.
    ndi_source_settings: ?NdiSourceSettings = null,

    /// A quality setting for the NDI Speed HQ encoder.
    ndi_speed_hq_quality: ?i32 = null,

    /// The protocol that is used by the source or output.
    ///
    /// Elemental MediaConnect no longer supports the Fujitsu QoS protocol. This
    /// reference is maintained for legacy purposes only.
    protocol: Protocol,

    /// The remote ID for the Zixi-pull stream.
    remote_id: ?[]const u8 = null,

    /// The port that the flow uses to send outbound requests to initiate connection
    /// with the sender.
    sender_control_port: ?i32 = null,

    /// The IP address that the flow communicates with to initiate connection with
    /// the sender.
    sender_ip_address: ?[]const u8 = null,

    /// The smoothing latency in milliseconds for RIST, RTP, and RTP-FEC streams.
    smoothing_latency: ?i32 = null,

    /// Source IP or domain name for SRT-caller protocol.
    source_listener_address: ?[]const u8 = null,

    /// Source port for SRT-caller protocol.
    source_listener_port: ?i32 = null,

    /// The stream ID that you want to use for this transport. This parameter
    /// applies only to Zixi and SRT caller-based streams.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr_allow_list = "CidrAllowList",
        .max_bitrate = "MaxBitrate",
        .max_latency = "MaxLatency",
        .max_sync_buffer = "MaxSyncBuffer",
        .min_latency = "MinLatency",
        .ndi_program_name = "NdiProgramName",
        .ndi_source_settings = "NdiSourceSettings",
        .ndi_speed_hq_quality = "NdiSpeedHqQuality",
        .protocol = "Protocol",
        .remote_id = "RemoteId",
        .sender_control_port = "SenderControlPort",
        .sender_ip_address = "SenderIpAddress",
        .smoothing_latency = "SmoothingLatency",
        .source_listener_address = "SourceListenerAddress",
        .source_listener_port = "SourceListenerPort",
        .stream_id = "StreamId",
    };
};
