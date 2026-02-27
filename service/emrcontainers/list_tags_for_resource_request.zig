pub const ListTagsForResourceRequest = struct {
    /// The ARN of tagged resources.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
