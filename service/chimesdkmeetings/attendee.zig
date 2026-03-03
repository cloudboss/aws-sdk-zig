const AttendeeCapabilities = @import("attendee_capabilities.zig").AttendeeCapabilities;

/// An Amazon Chime SDK meeting attendee. Includes a unique
/// `AttendeeId` and `JoinToken`. The
/// `JoinToken`
/// allows a client to authenticate and join as the specified attendee. The
/// `JoinToken`
/// expires when the meeting ends, or when
/// DeleteAttendee
/// is called. After that, the attendee is unable to join the meeting.
///
/// We recommend securely transferring each `JoinToken` from your server
/// application
/// to the client so that no other client has access to the token except for the
/// one
/// authorized to represent the attendee.
pub const Attendee = struct {
    /// The Amazon Chime SDK attendee ID.
    attendee_id: ?[]const u8 = null,

    /// The capabilities assigned to an attendee: audio, video, or content.
    ///
    /// You use the capabilities with a set of values that control what the
    /// capabilities can do, such as `SendReceive` data. For more information about
    /// those values, see
    /// .
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
    /// set your `video` capability
    /// to receive and you set your `content` capability to not receive.
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
    /// and if the attendee left their microphone unmuted, audio will flow from the
    /// attendee to the other meeting participants.
    ///
    /// * When you change a `video` or `content` capability from `None` or `Receive`
    ///   to `Send` or `SendReceive` ,
    /// and if the attendee turned on their video or content streams, remote
    /// attendees can receive those streams, but only after media renegotiation
    /// between the client and the Amazon Chime back-end server.
    capabilities: ?AttendeeCapabilities = null,

    /// The Amazon Chime SDK external user ID. An idempotency token. Links the
    /// attendee to an identity managed by a builder application.
    ///
    /// Pattern: `[-_&@+=,(){}\[\]\/«».:|'"#a-zA-Z0-9À-ÿ\s]*`
    ///
    /// Values that begin with `aws:` are reserved. You can't configure a value that
    /// uses this prefix.
    /// Case insensitive.
    external_user_id: ?[]const u8 = null,

    /// The join token used by the Amazon Chime SDK attendee.
    join_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attendee_id = "AttendeeId",
        .capabilities = "Capabilities",
        .external_user_id = "ExternalUserId",
        .join_token = "JoinToken",
    };
};
