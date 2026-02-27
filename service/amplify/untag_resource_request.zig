/// The request structure for the untag resource request.
pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) to use to untag a resource.
    resource_arn: []const u8,

    /// The tag keys to use to untag a resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
