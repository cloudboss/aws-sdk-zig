const aws = @import("aws");

const QuickConnectConfig = @import("quick_connect_config.zig").QuickConnectConfig;

/// Contains information about a quick connect.
pub const QuickConnect = struct {
    /// The description.
    description: ?[]const u8,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64,

    /// The name of the quick connect.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the quick connect.
    quick_connect_arn: ?[]const u8,

    /// Contains information about the quick connect.
    quick_connect_config: ?QuickConnectConfig,

    /// The identifier for the quick connect.
    quick_connect_id: ?[]const u8,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .description = "Description",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .quick_connect_arn = "QuickConnectARN",
        .quick_connect_config = "QuickConnectConfig",
        .quick_connect_id = "QuickConnectId",
        .tags = "Tags",
    };
};
