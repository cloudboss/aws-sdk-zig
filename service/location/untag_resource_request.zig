pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource from which you want to remove
    /// tags.
    ///
    /// * Format example:
    ///   `arn:aws:geo:region:account-id:resourcetype/ExampleResource`
    resource_arn: []const u8,

    /// The list of tag keys to remove from the specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
