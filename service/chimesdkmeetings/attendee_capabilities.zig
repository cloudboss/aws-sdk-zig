const MediaCapabilities = @import("media_capabilities.zig").MediaCapabilities;

/// The media capabilities of an attendee: audio, video, or content.
///
/// You use the capabilities with a set of values that control what the
/// capabilities can do, such as `SendReceive` data. For more information, refer
/// to
/// and .
///
/// When using capabilities, be aware of these corner cases:
///
/// * If you specify `MeetingFeatures:Video:MaxResolution:None` when you create
///   a meeting, all API requests
/// that include `SendReceive`, `Send`, or `Receive` for
/// `AttendeeCapabilities:Video` will be rejected with `ValidationError 400`.
///
/// * If you specify `MeetingFeatures:Content:MaxResolution:None` when you
///   create a meeting, all API requests that include `SendReceive`, `Send`, or
/// `Receive` for `AttendeeCapabilities:Content` will be rejected with
/// `ValidationError 400`.
///
/// * You can't set `content` capabilities to `SendReceive` or `Receive` unless
///   you also set `video` capabilities to `SendReceive`
/// or `Receive`. If you don't set the `video` capability to receive, the
/// response will contain an HTTP 400 Bad Request status code. However, you can
/// set your
/// `video` capability to receive and you set your `content` capability to not
/// receive.
///
/// * If meeting features is defined as `Video:MaxResolution:None` but
/// `Content:MaxResolution` is defined as something other than
/// `None` and attendee capabilities are not defined in the API
/// request, then the default attendee video capability is set to
/// `Receive` and attendee content capability is set to
/// `SendReceive`. This is because content `SendReceive`
/// requires video to be at least `Receive`.
///
/// * When you change an `audio` capability from `None` or `Receive` to `Send`
///   or `SendReceive` ,
/// and an attendee unmutes their microphone, audio flows from the attendee to
/// the other meeting participants.
///
/// * When you change a `video` or `content` capability from `None` or `Receive`
///   to `Send` or `SendReceive` ,
/// and the attendee turns on their video or content streams, remote attendees
/// can receive those streams, but only after media renegotiation between the
/// client and the Amazon Chime back-end server.
pub const AttendeeCapabilities = struct {
    /// The audio capability assigned to an attendee.
    audio: MediaCapabilities,

    /// The content capability assigned to an attendee.
    content: MediaCapabilities,

    /// The video capability assigned to an attendee.
    video: MediaCapabilities,

    pub const json_field_names = .{
        .audio = "Audio",
        .content = "Content",
        .video = "Video",
    };
};
