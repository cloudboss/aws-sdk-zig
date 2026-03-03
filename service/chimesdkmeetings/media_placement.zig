/// A set of endpoints used by clients to connect to the media service group for
/// an Amazon Chime SDK meeting.
pub const MediaPlacement = struct {
    /// The audio fallback URL.
    audio_fallback_url: ?[]const u8 = null,

    /// The audio host URL.
    audio_host_url: ?[]const u8 = null,

    /// The event ingestion URL.
    event_ingestion_url: ?[]const u8 = null,

    /// The screen data URL.
    ///
    /// **This parameter is deprecated and no longer used by the Amazon Chime SDK.**
    screen_data_url: ?[]const u8 = null,

    /// The screen sharing URL.
    ///
    /// **This parameter is deprecated and no longer used by the Amazon Chime SDK.**
    screen_sharing_url: ?[]const u8 = null,

    /// The screen viewing URL.
    ///
    /// **This parameter is deprecated and no longer used by the Amazon Chime SDK.**
    screen_viewing_url: ?[]const u8 = null,

    /// The signaling URL.
    signaling_url: ?[]const u8 = null,

    /// The turn control URL.
    ///
    /// **This parameter is deprecated and no longer used by the Amazon Chime SDK.**
    turn_control_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_fallback_url = "AudioFallbackUrl",
        .audio_host_url = "AudioHostUrl",
        .event_ingestion_url = "EventIngestionUrl",
        .screen_data_url = "ScreenDataUrl",
        .screen_sharing_url = "ScreenSharingUrl",
        .screen_viewing_url = "ScreenViewingUrl",
        .signaling_url = "SignalingUrl",
        .turn_control_url = "TurnControlUrl",
    };
};
