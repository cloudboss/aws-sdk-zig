pub const UntagResourceRequest = struct {
    /// The ARN of the pipeline that you want to untag.
    resource_arn: []const u8,

    /// The key/value pairs in the tag that you want to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
