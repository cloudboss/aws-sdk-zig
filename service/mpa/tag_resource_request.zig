const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// Amazon Resource Name (ARN) for the resource you want to tag.
    resource_arn: []const u8,

    /// Tags that you have added to the specified resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
