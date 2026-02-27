pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// A list of tag key value pairs that are associated with the resource.
    resource_tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .resource_tag_keys = "resourceTagKeys",
    };
};
