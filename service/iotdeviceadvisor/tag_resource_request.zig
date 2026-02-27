const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The resource ARN of an IoT Device Advisor resource. This can be
    /// SuiteDefinition ARN or
    /// SuiteRun ARN.
    resource_arn: []const u8,

    /// The tags to be attached to the IoT Device Advisor resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
