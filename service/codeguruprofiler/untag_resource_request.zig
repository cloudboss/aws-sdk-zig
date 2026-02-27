pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that contains the tags to
    /// remove.
    resource_arn: []const u8,

    /// A list of tag keys. Existing tags of resources with keys in this list are
    /// removed from
    /// the specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
