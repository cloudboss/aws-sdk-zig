const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the resource that you're adding tags to.
    resource_arn: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
