/// Object specifying a stream’s events. For a list of events, see [Using Amazon
/// EventBridge with Amazon
/// IVS](https://docs.aws.amazon.com/ivs/latest/userguide/eventbridge.html).
pub const StreamEvent = struct {
    /// Provides additional details about the stream event. There are several
    /// values; the long descriptions are provided in the IVS console but not
    /// delivered through the IVS API or EventBridge. Multitrack-related codes are
    /// used only for certain Session Ended events.
    ///
    /// * `MultitrackInputNotAllowed` — The broadcast client attempted to connect
    ///   with multitrack input, but multitrack input was not enabled on the
    ///   channel. Check your broadcast software settings or set
    ///   `MultitrackInputConfiguration.Policy` to `ALLOW` or `REQUIRE`.
    /// * `MultitrackInputRequired` — The broadcast client attempted to connect with
    ///   single-track video, but multitrack input is required on this channel.
    ///   Enable multitrack video in your broadcast software or configure the
    ///   channel’s `MultitrackInputConfiguration.Policy` to `ALLOW`.
    /// * `InvalidGetClientConfigurationStreamKey` — The broadcast client attempted
    ///   to connect with an invalid, expired, or corrupt stream key.
    /// * `GetClientConfigurationStreamKeyRequired` — The broadcast client attempted
    ///   to stream multitrack video without providing an authenticated stream key
    ///   from GetClientConfiguration.
    /// * `InvalidMultitrackInputTrackCount` — The multitrack input stream contained
    ///   an invalid number of tracks.
    /// * `InvalidMultitrackInputVideoTrackMediaProperties` — The multitrack input
    ///   stream contained one or more tracks with an invalid codec, resolution,
    ///   bitrate, or framerate.
    /// * `StreamTakeoverMediaMismatch` — The broadcast client attempted to take
    ///   over with different media properties (e.g., codec, resolution, or video
    ///   track type) from the original stream.
    /// * `StreamTakeoverInvalidPriority` — The broadcast client attempted a
    ///   takeover with either a priority integer value equal to or lower than the
    ///   original stream's value or a value outside the allowed range of 1 to
    ///   2,147,483,647.
    ///
    /// `StreamTakeoverLimitBreached` — The broadcast client reached the maximum
    /// allowed takeover attempts for this stream.
    code: ?[]const u8 = null,

    /// Time when the event occurred. This is an ISO 8601 timestamp; *note that this
    /// is returned as a string*.
    event_time: ?i64 = null,

    /// Name that identifies the stream event within a `type`.
    name: ?[]const u8 = null,

    /// Logical group for certain events.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .event_time = "eventTime",
        .name = "name",
        .@"type" = "type",
    };
};
