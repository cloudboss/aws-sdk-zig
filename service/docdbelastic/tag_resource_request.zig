const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN identifier of the elastic cluster resource.
    resource_arn: []const u8,

    /// The tags that are assigned to the elastic cluster resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
