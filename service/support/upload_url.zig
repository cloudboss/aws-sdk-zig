/// A presigned URL for uploading a single part of a multipart attachment
/// upload, along with
/// the part index and the date and time the URL expires. Returned by
/// GetAttachmentUploadLinks.
pub const UploadUrl = struct {
    /// The date and time, in ISO-8601 format, when the presigned URL expires.
    /// Upload the part
    /// before this time.
    expiry_date: []const u8,

    /// The index of the part that this URL uploads.
    part_index: i32 = 0,

    /// The presigned HTTPS URL that you use to upload a single part with HTTP
    /// `PUT`. Upload URLs are served from
    /// `uploadv1.attachments.support.{region}.amazonaws.com`. The
    /// `uploadv1` prefix is subject to change.
    url: []const u8,

    pub const json_field_names = .{
        .expiry_date = "expiryDate",
        .part_index = "partIndex",
        .url = "url",
    };
};
