const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to tag.
    resource_arn: []const u8,

    /// A map of the key-value pairs of the tag or tags to assign to the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
