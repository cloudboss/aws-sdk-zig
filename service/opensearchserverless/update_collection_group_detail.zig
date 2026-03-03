const CollectionGroupCapacityLimits = @import("collection_group_capacity_limits.zig").CollectionGroupCapacityLimits;

/// Details about the updated collection group.
pub const UpdateCollectionGroupDetail = struct {
    /// The Amazon Resource Name (ARN) of the collection group.
    arn: ?[]const u8 = null,

    /// The capacity limits for the collection group, in OpenSearch Compute Units
    /// (OCUs).
    capacity_limits: ?CollectionGroupCapacityLimits = null,

    /// The Epoch time when the collection group was created.
    created_date: ?i64 = null,

    /// The description of the collection group.
    description: ?[]const u8 = null,

    /// The unique identifier of the collection group.
    id: ?[]const u8 = null,

    /// The date and time when the collection group was last modified.
    last_modified_date: ?i64 = null,

    /// The name of the collection group.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .capacity_limits = "capacityLimits",
        .created_date = "createdDate",
        .description = "description",
        .id = "id",
        .last_modified_date = "lastModifiedDate",
        .name = "name",
    };
};
