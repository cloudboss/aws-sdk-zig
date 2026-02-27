pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the data store from which tags are being
    /// removed.
    resource_arn: []const u8,

    /// The keys for the tags to be removed from the data store.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
