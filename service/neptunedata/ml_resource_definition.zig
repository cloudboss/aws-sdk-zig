/// Defines a Neptune ML resource.
pub const MlResourceDefinition = struct {
    /// The resource ARN.
    arn: ?[]const u8 = null,

    /// The CloudWatch log URL for the resource.
    cloudwatch_log_url: ?[]const u8 = null,

    /// The failure reason, in case of a failure.
    failure_reason: ?[]const u8 = null,

    /// The resource name.
    name: ?[]const u8 = null,

    /// The output location.
    output_location: ?[]const u8 = null,

    /// The resource status.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cloudwatch_log_url = "cloudwatchLogUrl",
        .failure_reason = "failureReason",
        .name = "name",
        .output_location = "outputLocation",
        .status = "status",
    };
};
