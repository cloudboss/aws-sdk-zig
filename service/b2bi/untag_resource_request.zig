pub const UntagResourceRequest = struct {
    /// Specifies an Amazon Resource Name (ARN) for a specific Amazon Web Services
    /// resource, such as a capability, partnership, profile, or transformer.
    resource_arn: []const u8,

    /// Specifies the key-value pairs assigned to ARNs that you can use to group and
    /// search for resources by type. You can attach this metadata to resources
    /// (capabilities, partnerships, and so on) for any purpose.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
