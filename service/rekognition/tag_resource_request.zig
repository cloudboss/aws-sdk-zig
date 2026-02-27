const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// Amazon Resource Name (ARN) of the model, collection, or stream processor
    /// that you want to
    /// assign the tags to.
    resource_arn: []const u8,

    /// The key-value tags to assign to the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
