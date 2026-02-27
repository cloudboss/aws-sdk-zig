pub const UntagResourceRequest = struct {
    /// The ARN of the resource.
    resource_arn: []const u8,

    /// A list of tag key names to remove from the resource. You don't specify the
    /// value. Both
    /// the key and its associated value are removed.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
        .tag_keys = "tagKeys",
    };
};
