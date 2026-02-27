pub const ListTagsForResourceRequest = struct {
    /// The resource ARN of the IoT Device Advisor resource. This can be
    /// SuiteDefinition ARN or
    /// SuiteRun ARN.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
