pub const UntagResourceRequest = struct {
    /// The ARN of the resource to remove tags from.
    resource: []const u8,

    /// The list of tag keys to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource = "Resource",
        .tag_keys = "TagKeys",
    };
};
