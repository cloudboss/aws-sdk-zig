pub const ListTagsForResourceRequest = struct {
    /// The `GraphqlApi` Amazon Resource Name (ARN).
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
