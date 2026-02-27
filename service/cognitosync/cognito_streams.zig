const StreamingStatus = @import("streaming_status.zig").StreamingStatus;

/// Configuration options for configure Cognito streams.
pub const CognitoStreams = struct {
    /// The ARN of the role Amazon Cognito can assume in order to publish to the
    /// stream. This role must grant access to Amazon Cognito (cognito-sync) to
    /// invoke PutRecord on your Cognito stream.
    role_arn: ?[]const u8,

    /// Status of the Cognito streams. Valid values are:
    ///
    /// ENABLED - Streaming of updates to identity pool is enabled.
    ///
    /// DISABLED - Streaming of updates to identity pool is disabled. Bulk publish
    /// will also fail if StreamingStatus is DISABLED.
    streaming_status: ?StreamingStatus,

    /// The name of the Cognito stream to receive updates. This stream must be in
    /// the developers account and in the same region as the identity pool.
    stream_name: ?[]const u8,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
        .streaming_status = "StreamingStatus",
        .stream_name = "StreamName",
    };
};
