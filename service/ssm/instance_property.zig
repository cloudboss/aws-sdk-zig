const InstanceAggregatedAssociationOverview = @import("instance_aggregated_association_overview.zig").InstanceAggregatedAssociationOverview;
const PingStatus = @import("ping_status.zig").PingStatus;
const PlatformType = @import("platform_type.zig").PlatformType;
const SourceType = @import("source_type.zig").SourceType;

/// An object containing various properties of a managed node.
pub const InstanceProperty = struct {
    /// The activation ID created by Systems Manager when the server or virtual
    /// machine (VM) was
    /// registered
    activation_id: ?[]const u8 = null,

    /// The version of SSM Agent running on your managed node.
    agent_version: ?[]const u8 = null,

    /// The CPU architecture of the node. For example, `x86_64`.
    architecture: ?[]const u8 = null,

    association_overview: ?InstanceAggregatedAssociationOverview = null,

    /// The status of the State Manager association applied to the managed node.
    association_status: ?[]const u8 = null,

    /// The fully qualified host name of the managed node.
    computer_name: ?[]const u8 = null,

    /// The IAM role used in the hybrid activation to register the node with
    /// Systems Manager.
    iam_role: ?[]const u8 = null,

    /// The ID of the managed node.
    instance_id: ?[]const u8 = null,

    /// The instance profile attached to the node. If an instance profile isn't
    /// attached to the
    /// node, this value is blank.
    instance_role: ?[]const u8 = null,

    /// The current state of the node.
    instance_state: ?[]const u8 = null,

    /// The instance type of the managed node. For example, t3.large.
    instance_type: ?[]const u8 = null,

    /// The public IPv4 address assigned to the node. If a public IPv4 address isn't
    /// assigned to the
    /// node, this value is blank.
    ip_address: ?[]const u8 = null,

    /// The name of the key pair associated with the node. If a key pair isnt't
    /// associated with the
    /// node, this value is blank.
    key_name: ?[]const u8 = null,

    /// The date the association was last run.
    last_association_execution_date: ?i64 = null,

    /// The date and time when the SSM Agent last pinged the Systems Manager
    /// service.
    last_ping_date_time: ?i64 = null,

    /// The last date the association was successfully run.
    last_successful_association_execution_date: ?i64 = null,

    /// The timestamp for when the node was launched.
    launch_time: ?i64 = null,

    /// The value of the EC2 `Name` tag associated with the node. If a `Name`
    /// tag hasn't been applied to the node, this value is blank.
    name: ?[]const u8 = null,

    /// Connection status of the SSM Agent on the managed node.
    ping_status: ?PingStatus = null,

    /// The name of the operating system platform running on your managed node.
    platform_name: ?[]const u8 = null,

    /// The operating system platform type of the managed node. For example, Windows
    /// Server or
    /// Amazon Linux 2.
    platform_type: ?PlatformType = null,

    /// The version of the OS platform running on your managed node.
    platform_version: ?[]const u8 = null,

    /// The date the node was registered with Systems Manager.
    registration_date: ?i64 = null,

    /// The type of managed node.
    resource_type: ?[]const u8 = null,

    /// The ID of the source resource.
    source_id: ?[]const u8 = null,

    /// The type of the source resource.
    source_type: ?SourceType = null,

    pub const json_field_names = .{
        .activation_id = "ActivationId",
        .agent_version = "AgentVersion",
        .architecture = "Architecture",
        .association_overview = "AssociationOverview",
        .association_status = "AssociationStatus",
        .computer_name = "ComputerName",
        .iam_role = "IamRole",
        .instance_id = "InstanceId",
        .instance_role = "InstanceRole",
        .instance_state = "InstanceState",
        .instance_type = "InstanceType",
        .ip_address = "IPAddress",
        .key_name = "KeyName",
        .last_association_execution_date = "LastAssociationExecutionDate",
        .last_ping_date_time = "LastPingDateTime",
        .last_successful_association_execution_date = "LastSuccessfulAssociationExecutionDate",
        .launch_time = "LaunchTime",
        .name = "Name",
        .ping_status = "PingStatus",
        .platform_name = "PlatformName",
        .platform_type = "PlatformType",
        .platform_version = "PlatformVersion",
        .registration_date = "RegistrationDate",
        .resource_type = "ResourceType",
        .source_id = "SourceId",
        .source_type = "SourceType",
    };
};
