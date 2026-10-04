const StreamUrlStatus = @import("stream_url_status.zig").StreamUrlStatus;
const StreamUrlStatusReason = @import("stream_url_status_reason.zig").StreamUrlStatusReason;

/// Describes a stream URL. This is a summary view that omits the full
/// configuration, such as launch arguments and display settings. To retrieve
/// the complete configuration, call
/// [GetStreamUrl](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_GetStreamUrl.html).
pub const StreamUrlSummary = struct {
    /// The application that runs in the stream sessions.
    ///
    /// This value is an [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the application resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:application/a-9ZY8X7Wv6`.
    application_arn: ?[]const u8 = null,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the stream URL across all Amazon Web Services
    /// Regions. Format is `arn:aws:gameliftstreams:[AWS Region]:[AWS
    /// account]:streamurl/[stream group resource ID]/[stream URL resource ID]`.
    arn: []const u8,

    /// A timestamp that indicates when this resource was created. Timestamps are
    /// expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    created_at: ?i64 = null,

    /// The descriptive label for the stream URL.
    description: ?[]const u8 = null,

    /// The date and time when the stream URL expires and stops accepting new stream
    /// sessions. Timestamps are expressed using in ISO8601 format, such as:
    /// `2022-12-27T22:29:40+00:00` (UTC).
    expires_at: ?i64 = null,

    /// The number of times the stream URL can still be used to start a stream
    /// session.
    remaining_uses: ?i32 = null,

    /// The maximum length of time, in seconds, that a stream session started from
    /// this stream URL can run.
    session_length_seconds: ?i32 = null,

    /// The current status of the stream URL. Possible statuses include the
    /// following:
    ///
    /// * `ACTIVE`: The stream URL is valid and can start stream sessions.
    /// * `EXPIRED`: The stream URL has passed its expiration time and can no longer
    ///   start stream sessions.
    /// * `REVOKED`: The stream URL was revoked and can no longer start stream
    ///   sessions.
    /// * `LIMIT_REACHED`: The stream URL has been used the maximum number of times
    ///   and can no longer start stream sessions.
    status: ?StreamUrlStatus = null,

    /// Additional information about why the stream URL is in its current status.
    /// Amazon GameLift Streams populates this value when the status is `REVOKED`.
    /// Possible values include the following:
    ///
    /// * `userRevoked`: You revoked the stream URL.
    /// * `revokedAndTerminatingSessions`: You revoked the stream URL and Amazon
    ///   GameLift Streams is ending its running stream sessions.
    /// * `revokedAndSessionsTerminated`: You revoked the stream URL and its running
    ///   stream sessions have ended.
    /// * `streamGroupDeleted`: The stream group was deleted, which revoked the
    ///   stream URL.
    /// * `applicationDeleted`: The application was deleted, which revoked the
    ///   stream URL.
    status_reason: ?StreamUrlStatusReason = null,

    /// The stream group that runs the stream sessions.
    ///
    /// This value is an [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    stream_group_arn: ?[]const u8 = null,

    /// The shareable stream URL. Distribute this URL to end users so that they can
    /// start and play a stream session in a hosted web player. Treat the stream URL
    /// as a secret. Anyone who has it can start a stream session until the stream
    /// URL expires, is revoked, or reaches its usage limit.
    stream_url: ?[]const u8 = null,

    /// The unique identifier for the stream URL resource, for example
    /// `su-1AB2C3De4`.
    stream_url_id: ?[]const u8 = null,

    /// The maximum number of times the stream URL can start a stream session.
    usage_limit: ?i32 = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .expires_at = "ExpiresAt",
        .remaining_uses = "RemainingUses",
        .session_length_seconds = "SessionLengthSeconds",
        .status = "Status",
        .status_reason = "StatusReason",
        .stream_group_arn = "StreamGroupArn",
        .stream_url = "StreamUrl",
        .stream_url_id = "StreamUrlId",
        .usage_limit = "UsageLimit",
    };
};
