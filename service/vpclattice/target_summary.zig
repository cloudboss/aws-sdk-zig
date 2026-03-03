const TargetStatus = @import("target_status.zig").TargetStatus;

/// Summary information about a target.
pub const TargetSummary = struct {
    /// The ID of the target. If the target group type is `INSTANCE`, this is an
    /// instance ID. If the target group type is `IP`, this is an IP address. If the
    /// target group type is `LAMBDA`, this is the ARN of a Lambda function. If the
    /// target type is `ALB`, this is the ARN of an Application Load Balancer.
    id: ?[]const u8 = null,

    /// The port on which the target is listening.
    port: ?i32 = null,

    /// The code for why the target status is what it is.
    reason_code: ?[]const u8 = null,

    /// The status of the target.
    ///
    /// * `DRAINING`: The target is being deregistered. No new connections are sent
    ///   to this target while current connections are being drained. The default
    ///   draining time is 5 minutes.
    /// * `UNAVAILABLE`: Health checks are unavailable for the target group.
    /// * `HEALTHY`: The target is healthy.
    /// * `UNHEALTHY`: The target is unhealthy.
    /// * `INITIAL`: Initial health checks on the target are being performed.
    /// * `UNUSED`: Target group is not used in a service.
    status: ?TargetStatus = null,

    pub const json_field_names = .{
        .id = "id",
        .port = "port",
        .reason_code = "reasonCode",
        .status = "status",
    };
};
