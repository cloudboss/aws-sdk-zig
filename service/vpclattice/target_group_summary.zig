const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const LambdaEventStructureVersion = @import("lambda_event_structure_version.zig").LambdaEventStructureVersion;
const TargetGroupProtocol = @import("target_group_protocol.zig").TargetGroupProtocol;
const TargetGroupStatus = @import("target_group_status.zig").TargetGroupStatus;
const TargetGroupType = @import("target_group_type.zig").TargetGroupType;

/// Summary information about a target group.
///
/// For more information, see [Target
/// groups](https://docs.aws.amazon.com/vpc-lattice/latest/ug/target-groups.html) in the *Amazon VPC Lattice User Guide*.
pub const TargetGroupSummary = struct {
    /// The ARN (Amazon Resource Name) of the target group.
    arn: ?[]const u8 = null,

    /// The date and time that the target group was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The ID of the target group.
    id: ?[]const u8 = null,

    /// The type of IP address used for the target group. The possible values are
    /// `IPV4` and `IPV6`. This is an optional parameter. If not specified, the
    /// default is `IPV4`.
    ip_address_type: ?IpAddressType = null,

    /// The version of the event structure that your Lambda function receives.
    /// Supported only if the target group type is `LAMBDA`.
    lambda_event_structure_version: ?LambdaEventStructureVersion = null,

    /// The date and time that the target group was last updated, in ISO-8601
    /// format.
    last_updated_at: ?i64 = null,

    /// The name of the target group.
    name: ?[]const u8 = null,

    /// The port of the target group.
    port: ?i32 = null,

    /// The protocol of the target group.
    protocol: ?TargetGroupProtocol = null,

    /// The Amazon Resource Names (ARNs) of the service.
    service_arns: ?[]const []const u8 = null,

    /// The status.
    status: ?TargetGroupStatus = null,

    /// The target group type.
    @"type": ?TargetGroupType = null,

    /// The ID of the VPC of the target group.
    vpc_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .ip_address_type = "ipAddressType",
        .lambda_event_structure_version = "lambdaEventStructureVersion",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .port = "port",
        .protocol = "protocol",
        .service_arns = "serviceArns",
        .status = "status",
        .@"type" = "type",
        .vpc_identifier = "vpcIdentifier",
    };
};
