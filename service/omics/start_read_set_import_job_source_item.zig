const aws = @import("aws");

const SourceFiles = @import("source_files.zig").SourceFiles;
const FileType = @import("file_type.zig").FileType;

/// A source for a read set import job.
pub const StartReadSetImportJobSourceItem = struct {
    /// The source's description.
    description: ?[]const u8,

    /// Where the source originated.
    generated_from: ?[]const u8,

    /// The source's name.
    name: ?[]const u8,

    /// The source's reference ARN.
    reference_arn: ?[]const u8,

    /// The source's sample ID.
    sample_id: []const u8,

    /// The source files' location in Amazon S3.
    source_files: SourceFiles,

    /// The source's file type.
    source_file_type: FileType,

    /// The source's subject ID.
    subject_id: []const u8,

    /// The source's tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .description = "description",
        .generated_from = "generatedFrom",
        .name = "name",
        .reference_arn = "referenceArn",
        .sample_id = "sampleId",
        .source_files = "sourceFiles",
        .source_file_type = "sourceFileType",
        .subject_id = "subjectId",
        .tags = "tags",
    };
};
