pub const ListTagsForResourceRequest = struct {
    /// List tags for resource request by ARN.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
