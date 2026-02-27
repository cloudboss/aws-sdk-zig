pub const UntagResourceRequest = struct {
    /// A DataBrew resource from which you want to remove a tag or tags. The value
    /// for this
    /// parameter is an Amazon Resource Name (ARN).
    resource_arn: []const u8,

    /// The tag keys (names) of one or more tags to be removed.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
