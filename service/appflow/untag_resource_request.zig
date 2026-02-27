pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the flow that you want to untag.
    resource_arn: []const u8,

    /// The tag keys associated with the tag that you want to remove from your flow.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
