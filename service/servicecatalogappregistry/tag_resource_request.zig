const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon resource name (ARN) that specifies the resource.
    resource_arn: []const u8,

    /// The new or modified tags for the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
