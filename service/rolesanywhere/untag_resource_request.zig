pub const UntagResourceRequest = struct {
    /// The ARN of the resource.
    resource_arn: []const u8,

    /// A list of keys. Tag keys are the unique identifiers of tags.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
