pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) associated with this resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
