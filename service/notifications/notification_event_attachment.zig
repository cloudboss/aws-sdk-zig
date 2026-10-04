/// A file attached to a notification event.
pub const NotificationEventAttachment = struct {
    /// A temporary URL for downloading the attachment. The URL expires shortly
    /// after it's issued.
    attachment_download_url: ?[]const u8 = null,

    /// The MIME content type of the attachment, for example `application/pdf`.
    content_type: []const u8,

    /// The name of the attachment that recipients see.
    display_name: []const u8,

    pub const json_field_names = .{
        .attachment_download_url = "attachmentDownloadUrl",
        .content_type = "contentType",
        .display_name = "displayName",
    };
};
