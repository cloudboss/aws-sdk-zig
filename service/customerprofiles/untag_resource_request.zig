pub const UntagResourceRequest = struct {
    /// The ARN of the resource from which you are removing tags.
    resource_arn: []const u8,

    /// The list of tag keys to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
