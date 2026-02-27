pub const UntagResourceRequest = struct {
    /// The resource's Amazon Resource Name (ARN).
    resource: []const u8,

    /// A list of tag keys to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource = "Resource",
        .tag_keys = "TagKeys",
    };
};
