const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the resource the tag is associated with.
    resource_arn: []const u8,

    /// The list of tag keys and values to associate with the resource. You can
    /// associate tag
    /// keys only, tags (key and values) only or a combination of tag keys and tags.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
