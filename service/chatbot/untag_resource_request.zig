pub const UntagResourceRequest = struct {
    /// The value of the resource that will have the tag removed. An Amazon Resource
    /// Name (ARN) is an identifier for a specific AWS resource, such as a server,
    /// user, or role.
    resource_arn: []const u8,

    /// TagKeys are key-value pairs assigned to ARNs that can be used to group and
    /// search for resources by type. This metadata can be attached to resources for
    /// any purpose.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
