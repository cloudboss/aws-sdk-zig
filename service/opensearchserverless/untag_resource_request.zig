pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to remove tags from. The
    /// resource must be active (not in the `DELETING` state), and must be owned by
    /// the account ID included in the request.
    resource_arn: []const u8,

    /// The tag or set of tags to remove from the resource. All tag keys in the
    /// request must be unique.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
