/// UntagResourceRequest
pub const UntagResourceRequest = struct {
    /// Specifies the keys in the tags that you want to remove.
    keys: []const []const u8,

    /// Specifies the Amazon Resource Name (ARN) of the resource to remove the tags
    /// from.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .keys = "Keys",
        .resource_arn = "ResourceArn",
    };
};
