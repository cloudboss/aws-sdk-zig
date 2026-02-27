const aws = @import("aws");

const FileType = @import("file_type.zig").FileType;

/// Part of the response to ListMultipartReadSetUploads, excluding completed and
/// aborted multipart uploads.
pub const MultipartReadSetUploadListItem = struct {
    /// The time stamp for when a direct upload was created.
    creation_time: i64,

    /// The description of a read set.
    description: ?[]const u8,

    /// The source of an uploaded part.
    generated_from: []const u8,

    /// The name of a read set.
    name: ?[]const u8,

    /// The source's reference ARN.
    reference_arn: []const u8,

    /// The read set source's sample ID.
    sample_id: []const u8,

    /// The sequence store ID used for the multipart upload.
    sequence_store_id: []const u8,

    /// The type of file the read set originated from.
    source_file_type: FileType,

    /// The read set source's subject ID.
    subject_id: []const u8,

    /// Any tags you wish to add to a read set.
    tags: ?[]const aws.map.StringMapEntry,

    /// The ID for the initiated multipart upload.
    upload_id: []const u8,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .generated_from = "generatedFrom",
        .name = "name",
        .reference_arn = "referenceArn",
        .sample_id = "sampleId",
        .sequence_store_id = "sequenceStoreId",
        .source_file_type = "sourceFileType",
        .subject_id = "subjectId",
        .tags = "tags",
        .upload_id = "uploadId",
    };
};
