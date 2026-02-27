const ExportFilesMetadata = @import("export_files_metadata.zig").ExportFilesMetadata;
const Protocol = @import("protocol.zig").Protocol;
const StreamSessionStatus = @import("stream_session_status.zig").StreamSessionStatus;
const StreamSessionStatusReason = @import("stream_session_status_reason.zig").StreamSessionStatusReason;

/// Describes an Amazon GameLift Streams stream session. To retrieve additional
/// details for the stream session, call
/// [GetStreamSession](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_GetStreamSession.html).
pub const StreamSessionSummary = struct {
    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the application resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:application/a-9ZY8X7Wv6`.
    application_arn: ?[]const u8,

    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the stream session resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamsession/sg-1AB2C3De4/ABC123def4567`.
    arn: ?[]const u8,

    /// A timestamp that indicates when this resource was created. Timestamps are
    /// expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    created_at: ?i64,

    /// Provides details about the stream session's exported files.
    export_files_metadata: ?ExportFilesMetadata,

    /// A timestamp that indicates when this resource was last updated. Timestamps
    /// are expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    last_updated_at: ?i64,

    /// The location where Amazon GameLift Streams hosts and streams your
    /// application. For example, `us-east-1`. For a complete list of locations that
    /// Amazon GameLift Streams supports, refer to [Regions, quotas, and
    /// limitations](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/regions-quotas.html) in the *Amazon GameLift Streams Developer Guide*.
    location: ?[]const u8,

    /// The data transfer protocol in use with the stream session.
    protocol: ?Protocol,

    /// The current status of the stream session resource.
    ///
    /// * `ACTIVATING`: The stream session is starting and preparing to stream.
    /// * `ACTIVE`: The stream session is ready and waiting for a client connection.
    ///   A client has `ConnectionTimeoutSeconds` (specified in
    ///   `StartStreamSession`) from when the session reaches `ACTIVE` state to
    ///   establish a connection. If no client connects within this timeframe, the
    ///   session automatically terminates.
    /// * `CONNECTED`: The stream session has a connected client. A session will
    ///   automatically terminate if there is no user input for 60 minutes, or if
    ///   the maximum length of a session specified by `SessionLengthSeconds` in
    ///   `StartStreamSession` is exceeded.
    /// * `ERROR`: The stream session failed to activate. See `StatusReason`
    ///   (returned by `GetStreamSession` and `StartStreamSession`) for more
    ///   information.
    /// * `PENDING_CLIENT_RECONNECTION`: A client has recently disconnected and the
    ///   stream session is waiting for the client to reconnect. A client has
    ///   `ConnectionTimeoutSeconds` (specified in `StartStreamSession`) from when
    ///   the session reaches `PENDING_CLIENT_RECONNECTION` state to re-establish a
    ///   connection. If no client connects within this timeframe, the session
    ///   automatically terminates.
    /// * `RECONNECTING`: A client has initiated a reconnect to a session that was
    ///   in `PENDING_CLIENT_RECONNECTION` state.
    /// * `TERMINATING`: The stream session is ending.
    /// * `TERMINATED`: The stream session has ended.
    status: ?StreamSessionStatus,

    /// A short description of the reason the stream session is in `ERROR` status or
    /// `TERMINATED` status.
    ///
    /// `ERROR` status reasons:
    ///
    /// * `applicationLogS3DestinationError`: Could not write the application log to
    ///   the Amazon S3 bucket that is configured for the streaming application.
    ///   Make sure the bucket still exists.
    /// * `internalError`: An internal service error occurred. Start a new stream
    ///   session to continue streaming.
    /// * `invalidSignalRequest`: The WebRTC signal request that was sent is not
    ///   valid. When starting or reconnecting to a stream session, use
    ///   `generateSignalRequest` in the Amazon GameLift Streams Web SDK to generate
    ///   a new signal request.
    /// * `placementTimeout`: Amazon GameLift Streams could not find available
    ///   stream capacity to start a stream session. Increase the stream capacity in
    ///   the stream group or wait until capacity becomes available.
    ///
    /// `TERMINATED` status reasons:
    ///
    /// * `apiTerminated`: The stream session was terminated by an API call to
    ///   [TerminateStreamSession](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_TerminateStreamSession.html).
    /// * `applicationExit`: The streaming application exited or crashed. The stream
    ///   session was terminated because the application is no longer running.
    /// * `connectionTimeout`: The stream session was terminated because the client
    ///   failed to connect within the connection timeout period specified by
    ///   `ConnectionTimeoutSeconds`.
    /// * `idleTimeout`: The stream session was terminated because it exceeded the
    ///   idle timeout period of 60 minutes with no user input activity.
    /// * `maxSessionLengthTimeout`: The stream session was terminated because it
    ///   exceeded the maximum session length timeout period specified by
    ///   `SessionLengthSeconds`.
    /// * `reconnectionTimeout`: The stream session was terminated because the
    ///   client failed to reconnect within the reconnection timeout period
    ///   specified by `ConnectionTimeoutSeconds` after losing connection.
    status_reason: ?StreamSessionStatusReason,

    /// An opaque, unique identifier for an end-user, defined by the developer.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .arn = "Arn",
        .created_at = "CreatedAt",
        .export_files_metadata = "ExportFilesMetadata",
        .last_updated_at = "LastUpdatedAt",
        .location = "Location",
        .protocol = "Protocol",
        .status = "Status",
        .status_reason = "StatusReason",
        .user_id = "UserId",
    };
};
