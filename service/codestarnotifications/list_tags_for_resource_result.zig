const aws = @import("aws");

pub const ListTagsForResourceResult = struct {
    /// The tags associated with the notification rule.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
