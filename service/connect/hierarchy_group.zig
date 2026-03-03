const aws = @import("aws");

const HierarchyPath = @import("hierarchy_path.zig").HierarchyPath;

/// Contains information about a hierarchy group.
pub const HierarchyGroup = struct {
    /// The Amazon Resource Name (ARN) of the hierarchy group.
    arn: ?[]const u8 = null,

    /// Information about the levels in the hierarchy group.
    hierarchy_path: ?HierarchyPath = null,

    /// The identifier of the hierarchy group.
    id: ?[]const u8 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The identifier of the level in the hierarchy group.
    level_id: ?[]const u8 = null,

    /// The name of the hierarchy group.
    name: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .hierarchy_path = "HierarchyPath",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .level_id = "LevelId",
        .name = "Name",
        .tags = "Tags",
    };
};
