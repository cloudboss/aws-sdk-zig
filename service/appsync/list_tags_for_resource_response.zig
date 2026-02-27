const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A `TagMap` object.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
