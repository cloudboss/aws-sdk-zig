const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// Specify the `resourceArn` of the resource to which a tag will be added.
    resource_arn: []const u8,

    /// Specify the tags to add to the resource. Tags can be specified as a
    /// key-value map.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
