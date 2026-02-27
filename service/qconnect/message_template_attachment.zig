const ContentDisposition = @import("content_disposition.zig").ContentDisposition;

/// Information about the message template attachment.
pub const MessageTemplateAttachment = struct {
    /// The identifier of the attachment file.
    attachment_id: []const u8,

    /// The presentation information for the attachment file.
    content_disposition: ContentDisposition,

    /// The name of the attachment file being uploaded. The name should include the
    /// file extension.
    name: []const u8,

    /// The timestamp when the attachment file was uploaded.
    uploaded_time: i64,

    /// A pre-signed Amazon S3 URL that can be used to download the attachment file.
    url: []const u8,

    /// The expiration time of the pre-signed Amazon S3 URL.
    url_expiry: i64,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .content_disposition = "contentDisposition",
        .name = "name",
        .uploaded_time = "uploadedTime",
        .url = "url",
        .url_expiry = "urlExpiry",
    };
};
