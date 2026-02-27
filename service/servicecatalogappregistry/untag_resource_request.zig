pub const UntagResourceRequest = struct {
    /// The Amazon resource name (ARN) that specifies the resource.
    resource_arn: []const u8,

    /// A list of the tag keys to remove from the specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
