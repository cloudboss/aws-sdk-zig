pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource. For a list of supported
    /// resources, see
    /// [ResourceTag](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_ResourceTag.html).
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
