const CreationType = @import("creation_type.zig").CreationType;
const ETag = @import("e_tag.zig").ETag;
const FileType = @import("file_type.zig").FileType;
const SequenceInformation = @import("sequence_information.zig").SequenceInformation;
const ReadSetStatus = @import("read_set_status.zig").ReadSetStatus;

/// A read set.
pub const ReadSetListItem = struct {
    /// The read set's ARN.
    arn: []const u8,

    /// When the read set was created.
    creation_time: i64,

    /// The creation type of the read set.
    creation_type: ?CreationType,

    /// The read set's description.
    description: ?[]const u8,

    /// The entity tag (ETag) is a hash of the object representing its semantic
    /// content.
    etag: ?ETag,

    /// The read set's file type.
    file_type: FileType,

    /// The read set's ID.
    id: []const u8,

    /// The read set's name.
    name: ?[]const u8,

    /// The read set's genome reference ARN.
    reference_arn: ?[]const u8,

    /// The read set's sample ID.
    sample_id: ?[]const u8,

    sequence_information: ?SequenceInformation,

    /// The read set's sequence store ID.
    sequence_store_id: []const u8,

    /// The read set's status.
    status: ReadSetStatus,

    /// The status for a read set. It provides more detail as to why the read set
    /// has a status.
    status_message: ?[]const u8,

    /// The read set's subject ID.
    subject_id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .creation_type = "creationType",
        .description = "description",
        .etag = "etag",
        .file_type = "fileType",
        .id = "id",
        .name = "name",
        .reference_arn = "referenceArn",
        .sample_id = "sampleId",
        .sequence_information = "sequenceInformation",
        .sequence_store_id = "sequenceStoreId",
        .status = "status",
        .status_message = "statusMessage",
        .subject_id = "subjectId",
    };
};
