const CollectionGroupCapacityLimits = @import("collection_group_capacity_limits.zig").CollectionGroupCapacityLimits;

/// Summary information about a collection group.
pub const CollectionGroupSummary = struct {
    /// The Amazon Resource Name (ARN) of the collection group.
    arn: ?[]const u8 = null,

    capacity_limits: ?CollectionGroupCapacityLimits = null,

    /// The Epoch time when the collection group was created.
    created_date: ?i64 = null,

    /// The unique identifier of the collection group.
    id: ?[]const u8 = null,

    /// The name of the collection group.
    name: ?[]const u8 = null,

    /// The number of collections within the collection group.
    number_of_collections: ?i32 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .capacity_limits = "capacityLimits",
        .created_date = "createdDate",
        .id = "id",
        .name = "name",
        .number_of_collections = "numberOfCollections",
    };
};
