const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) to use to tag a resource.
    arn: []const u8,

    /// A map of tags assigned to a resource. A tag is a string-to-string map of
    /// key-value pairs.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .tags = "tags",
    };
};
