const aws = @import("aws");

/// Adds a tag to the specified resource.
pub const TagResourceRequest = struct {
    /// The ARN of the resource to add the tag to.
    resource_arn: []const u8,

    /// The tags to add to the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
