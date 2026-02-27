const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The resource's ARN.
    resource_arn: []const u8,

    /// Tags for the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
