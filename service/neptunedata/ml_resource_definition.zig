/// Defines a Neptune ML resource.
pub const MlResourceDefinition = struct {
    /// The resource ARN.
    arn: ?[]const u8,

    /// The CloudWatch log URL for the resource.
    cloudwatch_log_url: ?[]const u8,

    /// The failure reason, in case of a failure.
    failure_reason: ?[]const u8,

    /// The resource name.
    name: ?[]const u8,

    /// The output location.
    output_location: ?[]const u8,

    /// The resource status.
    status: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .cloudwatch_log_url = "cloudwatchLogUrl",
        .failure_reason = "failureReason",
        .name = "name",
        .output_location = "outputLocation",
        .status = "status",
    };
};
