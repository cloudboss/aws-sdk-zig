const aws = @import("aws");

/// A source for a reference import job.
pub const StartReferenceImportJobSourceItem = struct {
    /// The source's description.
    description: ?[]const u8,

    /// The source's name.
    name: []const u8,

    /// The source file's location in Amazon S3.
    source_file: []const u8,

    /// The source's tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .source_file = "sourceFile",
        .tags = "tags",
    };
};
