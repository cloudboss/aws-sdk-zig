pub const UntagResourceRequest = struct {
    /// The resource's ARN.
    resource_arn: []const u8,

    /// Tag keys to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
