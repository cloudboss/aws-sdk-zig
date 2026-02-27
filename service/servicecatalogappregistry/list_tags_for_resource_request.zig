pub const ListTagsForResourceRequest = struct {
    /// The Amazon resource name (ARN) that specifies the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
