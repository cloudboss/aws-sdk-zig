const CollectionStatus = @import("collection_status.zig").CollectionStatus;

/// Details about a deleted OpenSearch Serverless collection.
pub const DeleteCollectionDetail = struct {
    /// The unique identifier of the collection.
    id: ?[]const u8 = null,

    /// The name of the collection.
    name: ?[]const u8 = null,

    /// The current status of the collection.
    status: ?CollectionStatus = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
