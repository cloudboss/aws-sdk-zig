pub const UntagResourceRequest = struct {
    /// The unique identifier for the resource.
    resource_arn: []const u8,

    /// The keys of the tags to remove from the dashboard resource.
    resource_tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .resource_tag_keys = "resourceTagKeys",
    };
};
