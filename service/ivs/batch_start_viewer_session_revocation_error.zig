/// Error for a request in the batch for BatchStartViewerSessionRevocation. Each
/// error is
/// related to a specific channel-ARN and viewer-ID pair.
pub const BatchStartViewerSessionRevocationError = struct {
    /// Channel ARN.
    channel_arn: []const u8,

    /// Error code.
    code: ?[]const u8 = null,

    /// Error message, determined by the application.
    message: ?[]const u8 = null,

    /// The ID of the viewer session to revoke.
    viewer_id: []const u8,

    pub const json_field_names = .{
        .channel_arn = "channelArn",
        .code = "code",
        .message = "message",
        .viewer_id = "viewerId",
    };
};
