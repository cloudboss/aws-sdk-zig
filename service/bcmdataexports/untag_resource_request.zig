pub const UntagResourceRequest = struct {
    /// The unique identifier for the resource.
    resource_arn: []const u8,

    /// The tag keys that are associated with the resource ARN.
    resource_tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_tag_keys = "ResourceTagKeys",
    };
};
