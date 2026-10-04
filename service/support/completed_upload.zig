/// Identifies a single uploaded part of a multipart attachment upload. Pass a
/// list of
/// `CompletedUpload` objects to CompleteAttachmentUpload to
/// finalize the upload.
pub const CompletedUpload = struct {
    /// The ETag returned in the response headers when the part was uploaded to
    /// Amazon S3. The `ETag` value identifies the part contents.
    e_tag: []const u8,

    /// The index of the uploaded part. This is the same `partIndex` value returned
    /// for the corresponding entry in the `uploadUrls` field of the
    /// `GetAttachmentUploadLinks` response.
    part_index: i32,

    pub const json_field_names = .{
        .e_tag = "eTag",
        .part_index = "partIndex",
    };
};
