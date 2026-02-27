const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The ARN of the resource that you are viewing.
    resource_arn: []const u8,

    /// The list of tag keys and values associated with the resource you specified.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
