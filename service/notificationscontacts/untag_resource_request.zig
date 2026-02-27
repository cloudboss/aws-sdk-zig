pub const UntagResourceRequest = struct {
    /// The value of the resource that will have the tag removed. An Amazon Resource
    /// Name (ARN) is an identifier for a specific AWS resource, such as a server,
    /// user, or role.
    arn: []const u8,

    /// Specifies a list of tag keys that you want to remove from the specified
    /// resources.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .tag_keys = "tagKeys",
    };
};
