pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) associated with the deployment parameter
    /// resource you want to list tags on.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
