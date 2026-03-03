const aws = @import("aws");

/// This structure contains information about one group.
pub const Group = struct {
    /// The ARN of the group.
    arn: ?[]const u8 = null,

    /// The date and time that the group was created.
    created_time: ?i64 = null,

    /// The unique ID of the group.
    id: ?[]const u8 = null,

    /// The date and time that the group was most recently updated.
    last_modified_time: ?i64 = null,

    /// The name of the group.
    name: ?[]const u8 = null,

    /// The list of key-value pairs that are associated with the canary.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .id = "Id",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .tags = "Tags",
    };
};
