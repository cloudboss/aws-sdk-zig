/// Describes a target failure.
pub const TargetFailure = struct {
    /// The failure code.
    failure_code: ?[]const u8,

    /// The failure message.
    failure_message: ?[]const u8,

    /// The ID of the target. If the target group type is `INSTANCE`, this is an
    /// instance ID. If the target group type is `IP`, this is an IP address. If the
    /// target group type is `LAMBDA`, this is the ARN of a Lambda function. If the
    /// target group type is `ALB`, this is the ARN of an Application Load Balancer.
    id: ?[]const u8,

    /// The port on which the target is listening. This parameter doesn't apply if
    /// the target is a Lambda function.
    port: ?i32,

    pub const json_field_names = .{
        .failure_code = "failureCode",
        .failure_message = "failureMessage",
        .id = "id",
        .port = "port",
    };
};
