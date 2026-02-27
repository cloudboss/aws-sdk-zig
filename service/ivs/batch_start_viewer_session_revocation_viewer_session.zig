/// A viewer session to revoke in the call to BatchStartViewerSessionRevocation.
pub const BatchStartViewerSessionRevocationViewerSession = struct {
    /// The ARN of the channel associated with the viewer session to revoke.
    channel_arn: []const u8,

    /// The ID of the viewer associated with the viewer session to revoke. Do not
    /// use this field
    /// for personally identifying, confidential, or sensitive information.
    viewer_id: []const u8,

    /// An optional filter on which versions of the viewer session to revoke. All
    /// versions less
    /// than or equal to the specified version will be revoked. Default: 0.
    viewer_session_versions_less_than_or_equal_to: i32 = 0,

    pub const json_field_names = .{
        .channel_arn = "channelArn",
        .viewer_id = "viewerId",
        .viewer_session_versions_less_than_or_equal_to = "viewerSessionVersionsLessThanOrEqualTo",
    };
};
