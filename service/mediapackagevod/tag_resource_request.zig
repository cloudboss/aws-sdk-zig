const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the resource. You can get this from the
    /// response to any request to the resource.
    resource_arn: []const u8,

    /// A collection of tags associated with a resource
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
