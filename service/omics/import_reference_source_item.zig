const aws = @import("aws");

const ReferenceImportJobItemStatus = @import("reference_import_job_item_status.zig").ReferenceImportJobItemStatus;

/// An genome reference source.
pub const ImportReferenceSourceItem = struct {
    /// The source's description.
    description: ?[]const u8 = null,

    /// The source's name.
    name: ?[]const u8 = null,

    /// The source's reference ID.
    reference_id: ?[]const u8 = null,

    /// The source file's location in Amazon S3.
    source_file: ?[]const u8 = null,

    /// The source's status.
    status: ReferenceImportJobItemStatus,

    /// The source's status message.
    status_message: ?[]const u8 = null,

    /// The source's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .reference_id = "referenceId",
        .source_file = "sourceFile",
        .status = "status",
        .status_message = "statusMessage",
        .tags = "tags",
    };
};
