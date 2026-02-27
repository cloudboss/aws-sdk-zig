pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to return tags for. The
    /// Firewall Manager resources that support tagging are policies, applications
    /// lists, and protocols lists.
    resource_arn: []const u8,

    /// The keys of the tags to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
