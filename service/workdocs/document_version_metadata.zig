const aws = @import("aws");

const DocumentStatusType = @import("document_status_type.zig").DocumentStatusType;

/// Describes a version of a document.
pub const DocumentVersionMetadata = struct {
    /// The timestamp when the content of the document was originally created.
    content_created_timestamp: ?i64,

    /// The timestamp when the content of the document was modified.
    content_modified_timestamp: ?i64,

    /// The content type of the document.
    content_type: ?[]const u8,

    /// The timestamp when the document was first uploaded.
    created_timestamp: ?i64,

    /// The ID of the creator.
    creator_id: ?[]const u8,

    /// The ID of the version.
    id: ?[]const u8,

    /// The timestamp when the document was last uploaded.
    modified_timestamp: ?i64,

    /// The name of the version.
    name: ?[]const u8,

    /// The signature of the document.
    signature: ?[]const u8,

    /// The size of the document, in bytes.
    size: ?i64,

    /// The source of the document.
    source: ?[]const aws.map.StringMapEntry,

    /// The status of the document.
    status: ?DocumentStatusType,

    /// The thumbnail of the document.
    thumbnail: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .content_created_timestamp = "ContentCreatedTimestamp",
        .content_modified_timestamp = "ContentModifiedTimestamp",
        .content_type = "ContentType",
        .created_timestamp = "CreatedTimestamp",
        .creator_id = "CreatorId",
        .id = "Id",
        .modified_timestamp = "ModifiedTimestamp",
        .name = "Name",
        .signature = "Signature",
        .size = "Size",
        .source = "Source",
        .status = "Status",
        .thumbnail = "Thumbnail",
    };
};
