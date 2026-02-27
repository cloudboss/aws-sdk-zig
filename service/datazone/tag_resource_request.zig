const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the resource to be tagged in Amazon DataZone.
    resource_arn: []const u8,

    /// Specifies the tags for the `TagResource` action.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
