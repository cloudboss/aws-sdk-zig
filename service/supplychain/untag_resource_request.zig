/// The request parameters of UntagResource.
pub const UntagResourceRequest = struct {
    /// The Amazon Web Services Supply chain resource ARN that needs to be untagged.
    resource_arn: []const u8,

    /// The list of tag keys to be deleted for an Amazon Web Services Supply Chain
    /// resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
