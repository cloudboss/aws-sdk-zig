const HealthCheckConfig = @import("health_check_config.zig").HealthCheckConfig;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const LambdaEventStructureVersion = @import("lambda_event_structure_version.zig").LambdaEventStructureVersion;
const TargetGroupProtocol = @import("target_group_protocol.zig").TargetGroupProtocol;
const TargetGroupProtocolVersion = @import("target_group_protocol_version.zig").TargetGroupProtocolVersion;

/// Describes the configuration of a target group.
///
/// For more information, see [Target
/// groups](https://docs.aws.amazon.com/vpc-lattice/latest/ug/target-groups.html) in the *Amazon VPC Lattice User Guide*.
pub const TargetGroupConfig = struct {
    /// The health check configuration. Not supported if the target group type is
    /// `LAMBDA` or `ALB`.
    health_check: ?HealthCheckConfig,

    /// The type of IP address used for the target group. Supported only if the
    /// target group type is `IP`. The default is `IPV4`.
    ip_address_type: ?IpAddressType,

    /// The version of the event structure that your Lambda function receives.
    /// Supported only if the target group type is `LAMBDA`. The default is `V1`.
    lambda_event_structure_version: ?LambdaEventStructureVersion,

    /// The port on which the targets are listening. For HTTP, the default is 80.
    /// For HTTPS, the default is 443. Not supported if the target group type is
    /// `LAMBDA`.
    port: ?i32,

    /// The protocol to use for routing traffic to the targets. The default is the
    /// protocol of the target group. Not supported if the target group type is
    /// `LAMBDA`.
    protocol: ?TargetGroupProtocol,

    /// The protocol version. The default is `HTTP1`. Not supported if the target
    /// group type is `LAMBDA`.
    protocol_version: ?TargetGroupProtocolVersion,

    /// The ID of the VPC. Not supported if the target group type is `LAMBDA`.
    vpc_identifier: ?[]const u8,

    pub const json_field_names = .{
        .health_check = "healthCheck",
        .ip_address_type = "ipAddressType",
        .lambda_event_structure_version = "lambdaEventStructureVersion",
        .port = "port",
        .protocol = "protocol",
        .protocol_version = "protocolVersion",
        .vpc_identifier = "vpcIdentifier",
    };
};
