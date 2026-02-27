const ProtocolEnum = @import("protocol_enum.zig").ProtocolEnum;
const TargetGroupIpAddressTypeEnum = @import("target_group_ip_address_type_enum.zig").TargetGroupIpAddressTypeEnum;
const Matcher = @import("matcher.zig").Matcher;
const TargetTypeEnum = @import("target_type_enum.zig").TargetTypeEnum;

/// Information about a target group.
pub const TargetGroup = struct {
    /// Indicates whether health checks are enabled.
    health_check_enabled: ?bool,

    /// The approximate amount of time, in seconds, between health checks of an
    /// individual
    /// target.
    health_check_interval_seconds: ?i32,

    /// The destination for health checks on the targets.
    health_check_path: ?[]const u8,

    /// The port to use to connect with the target.
    health_check_port: ?[]const u8,

    /// The protocol to use to connect with the target. The GENEVE, TLS, UDP, and
    /// TCP_UDP
    /// protocols are not supported for health checks.
    health_check_protocol: ?ProtocolEnum,

    /// The amount of time, in seconds, during which no response means a failed
    /// health
    /// check.
    health_check_timeout_seconds: ?i32,

    /// The number of consecutive health checks successes required before
    /// considering an unhealthy
    /// target healthy.
    healthy_threshold_count: ?i32,

    /// The IP address type. The default value is `ipv4`.
    ip_address_type: ?TargetGroupIpAddressTypeEnum,

    /// The Amazon Resource Name (ARN) of the load balancer that routes traffic to
    /// this target
    /// group. You can use each target group with only one load balancer.
    load_balancer_arns: ?[]const []const u8,

    /// The HTTP or gRPC codes to use when checking for a successful response from a
    /// target.
    matcher: ?Matcher,

    /// The port on which the targets are listening. This parameter is not used if
    /// the target is
    /// a Lambda function.
    port: ?i32,

    /// The protocol to use for routing traffic to the targets.
    protocol: ?ProtocolEnum,

    /// [HTTP/HTTPS protocol] The protocol version. The possible values are `GRPC`,
    /// `HTTP1`, and `HTTP2`.
    protocol_version: ?[]const u8,

    /// The port on which the target control agent and application load balancer
    /// exchange management traffic for the target optimizer feature.
    target_control_port: ?i32,

    /// The Amazon Resource Name (ARN) of the target group.
    target_group_arn: ?[]const u8,

    /// The name of the target group.
    target_group_name: ?[]const u8,

    /// The type of target that you must specify when registering targets with this
    /// target group.
    /// The possible values are `instance` (register targets by instance ID),
    /// `ip` (register targets by IP address), `lambda` (register a single
    /// Lambda function as a target), or `alb` (register a single Application Load
    /// Balancer
    /// as a target).
    target_type: ?TargetTypeEnum,

    /// The number of consecutive health check failures required before considering
    /// the target
    /// unhealthy.
    unhealthy_threshold_count: ?i32,

    /// The ID of the VPC for the targets.
    vpc_id: ?[]const u8,
};
