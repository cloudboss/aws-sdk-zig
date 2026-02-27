pub const UntagResourceRequest = struct {
    /// The ARN of the MediaPackage resource that you're removing tags from.
    resource_arn: []const u8,

    /// The list of tag keys to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
