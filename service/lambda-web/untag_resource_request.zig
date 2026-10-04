/// The request to remove tags from a resource.
pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the web function.
    resource: []const u8,

    /// A list of tag keys to remove from the web function.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource = "resource",
        .tag_keys = "tagKeys",
    };
};
