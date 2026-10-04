/// A presigned URL for downloading an attachment, along with the date and time
/// the URL
/// expires. Returned by GetAttachmentDownloadLink.
pub const DownloadUrl = struct {
    /// The date and time, in ISO-8601 format, when the presigned URL expires.
    /// Download the
    /// attachment before this time.
    expiry_date: []const u8,

    /// The presigned HTTPS URL that you can use to download the attachment.
    /// Download URLs are
    /// served from `downloadv1.attachments.support.{region}.amazonaws.com`. The
    /// `downloadv1` prefix is subject to change.
    url: []const u8,

    pub const json_field_names = .{
        .expiry_date = "expiryDate",
        .url = "url",
    };
};
