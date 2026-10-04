/// The progress of a multipart attachment upload, returned by
/// DescribeAttachmentUploadStatus.
pub const UploadProgress = struct {
    /// The number of parts that have been successfully uploaded.
    completed_parts_count: ?i32 = null,

    /// The total number of parts that the file is split into.
    total_parts: ?i32 = null,

    pub const json_field_names = .{
        .completed_parts_count = "completedPartsCount",
        .total_parts = "totalParts",
    };
};
