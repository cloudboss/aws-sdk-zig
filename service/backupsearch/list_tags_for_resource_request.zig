pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the resource.>
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
