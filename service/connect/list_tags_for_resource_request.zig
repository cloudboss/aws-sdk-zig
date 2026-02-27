pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource. All Amazon Connect resources
    /// (instances, queues, flows, routing profiles, etc) have
    /// an ARN. To locate the ARN for an instance, for example, see [Find your
    /// Amazon Connect instance
    /// ID/ARN](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html).
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
