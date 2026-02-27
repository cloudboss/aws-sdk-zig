/// Removes a tag from the specified resource.
pub const UntagResourceRequest = struct {
    /// The ARN of the resource to remove the tag from.
    resource_arn: []const u8,

    /// The key for the tag to add.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
