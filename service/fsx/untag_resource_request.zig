/// The request object for `UntagResource` action.
pub const UntagResourceRequest = struct {
    /// The ARN of the Amazon FSx resource to untag.
    resource_arn: []const u8,

    /// A list of keys of tags on the resource to untag. In case the tag key doesn't
    /// exist,
    /// the call will still succeed to be idempotent.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
