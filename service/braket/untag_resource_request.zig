pub const UntagResourceRequest = struct {
    /// Specify the `resourceArn` for the resource from which to remove the tags.
    resource_arn: []const u8,

    /// Specify the keys for the tags to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
