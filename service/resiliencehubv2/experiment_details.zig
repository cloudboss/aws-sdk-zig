/// Details about an AWS Fault Injection Service (AWS FIS) experiment run as
/// part of a test run.
pub const ExperimentDetails = struct {
    /// Additional details about the experiment.
    details: ?[]const u8 = null,

    /// The ARN of the AWS FIS experiment.
    experiment_arn: []const u8,

    pub const json_field_names = .{
        .details = "details",
        .experiment_arn = "experimentArn",
    };
};
