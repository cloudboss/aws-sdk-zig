/// Removes a tag from a given resource.
pub const UntagResourceRequest = struct {
    /// The ARN of a resource that can be tagged.
    resource_arn: []const u8,

    /// The Tag keys to delete.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
