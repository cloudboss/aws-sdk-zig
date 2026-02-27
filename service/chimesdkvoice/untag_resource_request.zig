pub const UntagResourceRequest = struct {
    /// The ARN of the resource having its tags removed.
    resource_arn: []const u8,

    /// The keys of the tags being removed from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
