pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the resource. You can get this from the
    /// response to any request to the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
