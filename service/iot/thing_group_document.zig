const aws = @import("aws");

/// The thing group search index document.
pub const ThingGroupDocument = struct {
    /// The thing group attributes.
    attributes: ?[]const aws.map.StringMapEntry,

    /// Parent group names.
    parent_group_names: ?[]const []const u8,

    /// The thing group description.
    thing_group_description: ?[]const u8,

    /// The thing group ID.
    thing_group_id: ?[]const u8,

    /// The thing group name.
    thing_group_name: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .parent_group_names = "parentGroupNames",
        .thing_group_description = "thingGroupDescription",
        .thing_group_id = "thingGroupId",
        .thing_group_name = "thingGroupName",
    };
};
