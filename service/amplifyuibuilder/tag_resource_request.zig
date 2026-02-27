const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) to use to tag a resource.
    resource_arn: []const u8,

    /// A list of tag key value pairs for a specified Amazon Resource Name (ARN).
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
