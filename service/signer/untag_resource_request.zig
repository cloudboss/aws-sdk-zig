pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the signing profile.
    resource_arn: []const u8,

    /// A list of tag keys to be removed from the signing profile.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
