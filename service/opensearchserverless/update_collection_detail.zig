const CollectionStatus = @import("collection_status.zig").CollectionStatus;
const CollectionType = @import("collection_type.zig").CollectionType;

/// Details about an updated OpenSearch Serverless collection.
pub const UpdateCollectionDetail = struct {
    /// The Amazon Resource Name (ARN) of the collection.
    arn: ?[]const u8,

    /// The date and time when the collection was created.
    created_date: ?i64,

    /// The description of the collection.
    description: ?[]const u8,

    /// The unique identifier of the collection.
    id: ?[]const u8,

    /// The date and time when the collection was last modified.
    last_modified_date: ?i64,

    /// The name of the collection.
    name: ?[]const u8,

    /// The current status of the collection.
    status: ?CollectionStatus,

    /// The collection type.
    @"type": ?CollectionType,

    pub const json_field_names = .{
        .arn = "arn",
        .created_date = "createdDate",
        .description = "description",
        .id = "id",
        .last_modified_date = "lastModifiedDate",
        .name = "name",
        .status = "status",
        .@"type" = "type",
    };
};
