pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the retention rule.
    resource_arn: []const u8,

    /// The tag keys of the tags to unassign. All tags that have the specified tag
    /// key are unassigned.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
