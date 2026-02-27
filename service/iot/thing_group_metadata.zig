const GroupNameAndArn = @import("group_name_and_arn.zig").GroupNameAndArn;

/// Thing group metadata.
pub const ThingGroupMetadata = struct {
    /// The UNIX timestamp of when the thing group was created.
    creation_date: ?i64,

    /// The parent thing group name.
    parent_group_name: ?[]const u8,

    /// The root parent thing group.
    root_to_parent_thing_groups: ?[]const GroupNameAndArn,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .parent_group_name = "parentGroupName",
        .root_to_parent_thing_groups = "rootToParentThingGroups",
    };
};
