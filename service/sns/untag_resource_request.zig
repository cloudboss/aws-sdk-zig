pub const UntagResourceRequest = struct {
    /// The ARN of the topic from which to remove tags.
    resource_arn: []const u8,

    /// The list of tag keys to remove from the specified topic.
    tag_keys: []const []const u8,
};
