const CollectionStatus = @import("collection_status.zig").CollectionStatus;

/// A list of filter keys that you can use for LIST, UPDATE, and DELETE requests
/// to OpenSearch Serverless collections.
pub const CollectionFilters = struct {
    /// The name of the collection group to filter by.
    collection_group_name: ?[]const u8,

    /// The name of the collection.
    name: ?[]const u8,

    /// The current status of the collection.
    status: ?CollectionStatus,

    pub const json_field_names = .{
        .collection_group_name = "collectionGroupName",
        .name = "name",
        .status = "status",
    };
};
