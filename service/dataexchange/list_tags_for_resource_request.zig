pub const ListTagsForResourceRequest = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies an AWS resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
