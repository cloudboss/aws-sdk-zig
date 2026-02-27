pub const UntagResourceRequest = struct {
    /// The ARN identifier of the elastic cluster resource.
    resource_arn: []const u8,

    /// The tag keys to be removed from the elastic cluster resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
