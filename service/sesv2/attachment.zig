const AttachmentContentDisposition = @import("attachment_content_disposition.zig").AttachmentContentDisposition;
const AttachmentContentTransferEncoding = @import("attachment_content_transfer_encoding.zig").AttachmentContentTransferEncoding;

/// Contains metadata and attachment raw content.
pub const Attachment = struct {
    /// A brief description of the attachment content.
    content_description: ?[]const u8,

    /// A standard descriptor indicating how the attachment should be rendered in
    /// the email.
    /// Supported values: `ATTACHMENT` or `INLINE`.
    content_disposition: ?AttachmentContentDisposition,

    /// Unique identifier for the attachment, used for referencing attachments with
    /// INLINE disposition in HTML content.
    content_id: ?[]const u8,

    /// Specifies how the attachment is encoded.
    /// Supported values: `BASE64`, `QUOTED_PRINTABLE`, `SEVEN_BIT`.
    content_transfer_encoding: ?AttachmentContentTransferEncoding,

    /// The MIME type of the attachment.
    ///
    /// Example: `application/pdf`, `image/jpeg`
    content_type: ?[]const u8,

    /// The file name for the attachment as it will appear in the email.
    /// Amazon SES restricts certain file extensions. To ensure attachments are
    /// accepted,
    /// check the [Unsupported attachment
    /// types](https://docs.aws.amazon.com/ses/latest/dg/mime-types.html)
    /// in the Amazon SES Developer Guide.
    file_name: []const u8,

    /// The raw data of the attachment. It needs to be base64-encoded if you are
    /// accessing Amazon SES
    /// directly through the HTTPS interface. If you are accessing Amazon SES using
    /// an Amazon Web Services
    /// SDK, the SDK takes care of the base 64-encoding for you.
    raw_content: []const u8,

    pub const json_field_names = .{
        .content_description = "ContentDescription",
        .content_disposition = "ContentDisposition",
        .content_id = "ContentId",
        .content_transfer_encoding = "ContentTransferEncoding",
        .content_type = "ContentType",
        .file_name = "FileName",
        .raw_content = "RawContent",
    };
};
