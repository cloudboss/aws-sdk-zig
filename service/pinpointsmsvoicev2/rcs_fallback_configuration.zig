const RcsFallbackChannel = @import("rcs_fallback_channel.zig").RcsFallbackChannel;

/// Configuration for SMS or MMS fallback when RCS delivery fails or the
/// TimeToLive expires without delivery confirmation.
pub const RcsFallbackConfiguration = struct {
    /// The fallback channel to use when RCS delivery fails. Valid values are SMS
    /// and MMS. SMS and MMS are mutually exclusive.
    channel: RcsFallbackChannel,

    /// An array of S3 URIs to media files for MMS fallback. Only valid when Channel
    /// is MMS.
    media_urls: ?[]const []const u8 = null,

    /// The text body of the fallback message. Required for SMS fallback. For MMS
    /// fallback, at least one of MessageBody or MediaUrls must be provided.
    message_body: ?[]const u8 = null,

    /// The origination identity to use for the fallback message. This can be a
    /// PhoneNumber, PhoneNumberId, PhoneNumberArn, SenderId, or SenderIdArn. Pool
    /// IDs and pool ARNs are not accepted. If not specified and the original
    /// message was sent via a pool, the service selects a suitable number from the
    /// pool.
    origination_identity: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel = "Channel",
        .media_urls = "MediaUrls",
        .message_body = "MessageBody",
        .origination_identity = "OriginationIdentity",
    };
};
