const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// An array of user-defined keys and optional values. These tags can be used
    /// for categorization and organization.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
