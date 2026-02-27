pub const ListTagsForResourceRequest = struct {
    /// The resource's ARN.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
