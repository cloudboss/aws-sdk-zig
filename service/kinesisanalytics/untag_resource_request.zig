pub const UntagResourceRequest = struct {
    /// The ARN of the Kinesis Analytics application from which to remove the tags.
    resource_arn: []const u8,

    /// A list of keys of tags to remove from the specified application.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
