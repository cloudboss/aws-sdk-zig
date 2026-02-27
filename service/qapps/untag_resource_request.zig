pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to disassociate the tag from.
    resource_arn: []const u8,

    /// The keys of the tags to disassociate from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
        .tag_keys = "tagKeys",
    };
};
