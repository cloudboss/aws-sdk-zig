const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the resource to apply tags to.
    resource_arn: []const u8,

    /// The list of tag keys and values to associate with the resource.
    ///
    /// Keys must not begin with `aws:`.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
