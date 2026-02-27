pub const ListTagsForResourceRequest = struct {
    /// The ARN of the CloudWatch resource that you want to view tags for.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
