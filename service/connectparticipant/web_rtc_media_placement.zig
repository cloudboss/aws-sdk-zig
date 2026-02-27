/// A set of endpoints used by clients to connect to the media service group for
/// an
/// Amazon Chime SDK meeting.
pub const WebRTCMediaPlacement = struct {
    /// The audio fallback URL.
    audio_fallback_url: ?[]const u8,

    /// The audio host URL.
    audio_host_url: ?[]const u8,

    /// The event ingestion URL to which you send client meeting events.
    event_ingestion_url: ?[]const u8,

    /// The signaling URL.
    signaling_url: ?[]const u8,

    pub const json_field_names = .{
        .audio_fallback_url = "AudioFallbackUrl",
        .audio_host_url = "AudioHostUrl",
        .event_ingestion_url = "EventIngestionUrl",
        .signaling_url = "SignalingUrl",
    };
};
