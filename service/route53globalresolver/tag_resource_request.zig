const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// Amazon Resource Name (ARN) of the resource to be tagged.
    resource_arn: []const u8,

    /// An array of user-defined keys and optional values. These tags can be used
    /// for categorization and organization.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
