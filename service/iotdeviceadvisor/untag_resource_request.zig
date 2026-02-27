pub const UntagResourceRequest = struct {
    /// The resource ARN of an IoT Device Advisor resource. This can be
    /// SuiteDefinition ARN or
    /// SuiteRun ARN.
    resource_arn: []const u8,

    /// List of tag keys to remove from the IoT Device Advisor resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
