const aws = @import("aws");

const SourceFiles = @import("source_files.zig").SourceFiles;
const FileType = @import("file_type.zig").FileType;
const ReadSetImportJobItemStatus = @import("read_set_import_job_item_status.zig").ReadSetImportJobItemStatus;

/// A source for an import read set job.
pub const ImportReadSetSourceItem = struct {
    /// The source's description.
    description: ?[]const u8 = null,

    /// Where the source originated.
    generated_from: ?[]const u8 = null,

    /// The source's name.
    name: ?[]const u8 = null,

    /// The source's read set ID.
    read_set_id: ?[]const u8 = null,

    /// The source's genome reference ARN.
    reference_arn: ?[]const u8 = null,

    /// The source's sample ID.
    sample_id: []const u8,

    /// The source files' location in Amazon S3.
    source_files: SourceFiles,

    /// The source's file type.
    source_file_type: FileType,

    /// The source's status.
    status: ReadSetImportJobItemStatus,

    /// The source's status message.
    status_message: ?[]const u8 = null,

    /// The source's subject ID.
    subject_id: []const u8,

    /// The source's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "description",
        .generated_from = "generatedFrom",
        .name = "name",
        .read_set_id = "readSetId",
        .reference_arn = "referenceArn",
        .sample_id = "sampleId",
        .source_files = "sourceFiles",
        .source_file_type = "sourceFileType",
        .status = "status",
        .status_message = "statusMessage",
        .subject_id = "subjectId",
        .tags = "tags",
    };
};
