pub const ListTagsForResourceRequest = struct {
    /// The ARN identifier of the elastic cluster resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
