const CollectionGroupCapacityLimits = @import("collection_group_capacity_limits.zig").CollectionGroupCapacityLimits;
const StandbyReplicas = @import("standby_replicas.zig").StandbyReplicas;
const Tag = @import("tag.zig").Tag;

/// Details about the created collection group.
pub const CreateCollectionGroupDetail = struct {
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

    /// The name of the collection group.
    name: ?[]const u8 = null,

    /// Indicates whether standby replicas are used for the collection group.
    standby_replicas: ?StandbyReplicas = null,

    /// A map of key-value pairs associated with the collection group.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .arn = "arn",
        .capacity_limits = "capacityLimits",
        .created_date = "createdDate",
        .description = "description",
        .id = "id",
        .name = "name",
        .standby_replicas = "standbyReplicas",
        .tags = "tags",
    };
};
