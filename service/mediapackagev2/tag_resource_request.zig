const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the MediaPackage resource that you're adding tags to.
    resource_arn: []const u8,

    /// Contains a map of the key-value pairs for the resource tag or tags assigned
    /// to the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
