const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to which to add tags.
    resource_arn: []const u8,

    /// The tags to add to the resource as a list of key-value pairs.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
