const ComputeStatus = @import("compute_status.zig").ComputeStatus;
const ContainerAttribute = @import("container_attribute.zig").ContainerAttribute;
const OperatingSystem = @import("operating_system.zig").OperatingSystem;
const EC2InstanceType = @import("ec2_instance_type.zig").EC2InstanceType;

/// An Amazon GameLift Servers compute resource for hosting your game servers.
/// Computes in an Amazon GameLift Servers
/// fleet differs depending on the fleet's compute type property as follows:
///
/// * For managed EC2 fleets, a compute is an EC2 instance.
///
/// * For Anywhere fleets, a compute is a computing resource that you provide
///   and is
/// registered to the fleet.
pub const Compute = struct {
    /// The ARN that is assigned to a compute resource and uniquely identifies it.
    /// ARNs are
    /// unique across locations. Instances in managed EC2 fleets are not assigned a
    /// Compute
    /// ARN.
    compute_arn: ?[]const u8 = null,

    /// A descriptive label for the compute resource. For instances in a managed EC2
    /// fleet, the compute name is the same value as the `InstanceId`
    /// ID.
    compute_name: ?[]const u8 = null,

    /// Current status of the compute. A compute must have an `ACTIVE` status to
    /// host game sessions. Valid values include `PENDING`, `ACTIVE`, `TERMINATING`,
    /// and `IMPAIRED`.
    ///
    /// While the ComputeStatus enum type is valid for Container based servers, the
    /// result may also include other non-enumerated string values such as "Active"
    /// for fleets which are not Container-based.
    compute_status: ?ComputeStatus = null,

    /// A set of attributes for each container in the compute.
    container_attributes: ?[]const ContainerAttribute = null,

    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64 = null,

    /// The DNS name of a compute resource. Amazon GameLift Servers requires a DNS
    /// name or IP address for a
    /// compute.
    dns_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the fleet that the compute belongs to.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the fleet that the compute belongs to.
    fleet_id: ?[]const u8 = null,

    /// The endpoint of the Amazon GameLift Servers Agent.
    game_lift_agent_endpoint: ?[]const u8 = null,

    /// The Amazon GameLift Servers SDK endpoint connection for a registered compute
    /// resource in an Anywhere
    /// fleet. The game servers on the compute use this endpoint to connect to the
    /// Amazon GameLift Servers
    /// service.
    game_lift_service_sdk_endpoint: ?[]const u8 = null,

    /// The game server container group definition for the compute.
    game_server_container_group_definition_arn: ?[]const u8 = null,

    /// The `InstanceID` of the EC2 instance that is hosting the compute.
    instance_id: ?[]const u8 = null,

    /// The IP address of a compute resource. Amazon GameLift Servers requires a DNS
    /// name or IP address for a
    /// compute.
    ip_address: ?[]const u8 = null,

    /// The name of the custom location you added to the fleet that this compute
    /// resource
    /// resides in.
    location: ?[]const u8 = null,

    /// The type of operating system on the compute resource.
    ///
    /// Amazon Linux 2 (AL2) will reach end of support on 6/30/2026. See more
    /// details in
    /// the [Amazon Linux 2
    /// FAQs](http://aws.amazon.com/aws.amazon.com/amazon-linux-2/faqs/).
    /// For game servers
    /// that are hosted on AL2 and use server SDK version 4.x for Amazon GameLift
    /// Servers, first update the
    /// game server build to server SDK 5.x, and then deploy to AL2023 instances.
    /// See
    /// [
    /// Migrate to server SDK version
    /// 5.](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-serversdk5-migration.html)
    operating_system: ?OperatingSystem = null,

    /// The Amazon EC2 instance type that the fleet uses. For registered computes in
    /// an Amazon GameLift Servers Anywhere fleet, this property is empty.
    @"type": ?EC2InstanceType = null,

    pub const json_field_names = .{
        .compute_arn = "ComputeArn",
        .compute_name = "ComputeName",
        .compute_status = "ComputeStatus",
        .container_attributes = "ContainerAttributes",
        .creation_time = "CreationTime",
        .dns_name = "DnsName",
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .game_lift_agent_endpoint = "GameLiftAgentEndpoint",
        .game_lift_service_sdk_endpoint = "GameLiftServiceSdkEndpoint",
        .game_server_container_group_definition_arn = "GameServerContainerGroupDefinitionArn",
        .instance_id = "InstanceId",
        .ip_address = "IpAddress",
        .location = "Location",
        .operating_system = "OperatingSystem",
        .@"type" = "Type",
    };
};
