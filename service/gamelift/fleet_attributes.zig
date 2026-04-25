const AnywhereConfiguration = @import("anywhere_configuration.zig").AnywhereConfiguration;
const CertificateConfiguration = @import("certificate_configuration.zig").CertificateConfiguration;
const ComputeType = @import("compute_type.zig").ComputeType;
const FleetType = @import("fleet_type.zig").FleetType;
const InstanceRoleCredentialsProvider = @import("instance_role_credentials_provider.zig").InstanceRoleCredentialsProvider;
const EC2InstanceType = @import("ec2_instance_type.zig").EC2InstanceType;
const ProtectionPolicy = @import("protection_policy.zig").ProtectionPolicy;
const OperatingSystem = @import("operating_system.zig").OperatingSystem;
const PlayerGatewayConfiguration = @import("player_gateway_configuration.zig").PlayerGatewayConfiguration;
const PlayerGatewayMode = @import("player_gateway_mode.zig").PlayerGatewayMode;
const ResourceCreationLimitPolicy = @import("resource_creation_limit_policy.zig").ResourceCreationLimitPolicy;
const FleetStatus = @import("fleet_status.zig").FleetStatus;
const FleetAction = @import("fleet_action.zig").FleetAction;

/// Describes an Amazon GameLift Servers fleet of game hosting resources.
/// Attributes differ based on
/// the fleet's compute type, as follows:
///
/// * EC2 fleet attributes identify a `Build` resource (for fleets with
/// customer game server builds) or a `Script` resource (for Amazon GameLift
/// Servers Realtime fleets).
///
/// * Amazon GameLift Servers Anywhere fleets have an abbreviated set of
///   attributes, because most fleet configurations
/// are set directly on the fleet's computes. Attributes include fleet
/// identifiers and descriptive
/// properties, creation/termination time, and fleet status.
///
/// **Returned by:**
/// [https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeFleetAttributes](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeFleetAttributes)
pub const FleetAttributes = struct {
    /// A set of attributes that are specific to an Anywhere fleet.
    anywhere_configuration: ?AnywhereConfiguration = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// associated with the Amazon GameLift Servers build resource that is deployed
    /// on instances in
    /// this fleet. In a GameLift build ARN, the resource ID matches the `BuildId`
    /// value. This attribute is used with fleets where `ComputeType` is "EC2".
    build_arn: ?[]const u8 = null,

    /// A unique identifier for the build resource that is deployed on instances in
    /// this fleet. This attribute is used with
    /// fleets where `ComputeType` is "EC2".
    build_id: ?[]const u8 = null,

    /// Determines whether a TLS/SSL certificate is generated for a fleet. This
    /// feature must be enabled when creating the fleet.
    /// All instances in a fleet share the same certificate.
    certificate_configuration: ?CertificateConfiguration = null,

    /// The type of compute resource used to host your game servers. You can use
    /// your own
    /// compute resources with Amazon GameLift Servers Anywhere or use Amazon EC2
    /// instances with managed
    /// Amazon GameLift Servers.
    compute_type: ?ComputeType = null,

    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64 = null,

    /// A human-readable description of the fleet.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers fleet resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::fleet/fleet-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`. In a
    /// GameLift fleet ARN, the resource ID matches the `FleetId`
    /// value.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the fleet.
    fleet_id: ?[]const u8 = null,

    /// Indicates whether the fleet uses On-Demand or Spot instances. For more
    /// information,
    /// see [ On-Demand versus Spot
    /// Instances](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-ec2-instances.html#gamelift-ec2-instances-spot). This fleet property can't be changed after the fleet is created.
    fleet_type: ?FleetType = null,

    /// A unique identifier for an IAM role that manages access to your Amazon Web
    /// Services services.
    /// With an instance role ARN set, any application that runs on an instance in
    /// this fleet can assume the role,
    /// including install scripts, server processes, and daemons (background
    /// processes). Create a role or look up a role's
    /// ARN by using the [IAM dashboard](https://console.aws.amazon.com/iam/) in the
    /// Amazon Web Services Management Console.
    /// Learn more about using on-box credentials for your game servers at
    /// [
    /// Access external resources from a game
    /// server](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-resources.html). This attribute is used with fleets where `ComputeType` is
    /// `EC2`.
    instance_role_arn: ?[]const u8 = null,

    /// Indicates that fleet instances maintain a shared credentials file for the
    /// IAM role defined in `InstanceRoleArn`. Shared credentials allow
    /// applications that are deployed with the game server executable to
    /// communicate with other
    /// Amazon Web Services resources. This property is used only when the game
    /// server is integrated with the
    /// server SDK version 5.x. For more information about using shared credentials,
    /// see [ Communicate
    /// with other Amazon Web Services resources from your
    /// fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-resources.html). This attribute is used with
    /// fleets where `ComputeType` is `EC2`.
    instance_role_credentials_provider: ?InstanceRoleCredentialsProvider = null,

    /// The Amazon EC2 instance type that the fleet uses. Instance type determines
    /// the computing
    /// resources of each instance in the fleet, including CPU, memory, storage, and
    /// networking
    /// capacity. See [Amazon Elastic Compute Cloud Instance
    /// Types](http://aws.amazon.com/ec2/instance-types/) for detailed descriptions.
    /// This attribute is used with fleets where
    /// `ComputeType` is `EC2`.
    instance_type: ?EC2InstanceType = null,

    /// **This parameter is no longer used.** Game session log
    /// paths are now defined using the Amazon GameLift Servers server API
    /// `ProcessReady()`
    /// `logParameters`. See more information in the [Server API
    /// Reference](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-api-ref.html#gamelift-sdk-server-api-ref-dataypes-process).
    log_paths: ?[]const []const u8 = null,

    /// Name of a metric group that metrics for this fleet are added to. In Amazon
    /// CloudWatch,
    /// you can view aggregated metrics for fleets that are in a metric group. A
    /// fleet can be
    /// included in only one metric group at a time. This attribute is used with
    /// fleets where
    /// `ComputeType` is `EC2`.
    metric_groups: ?[]const []const u8 = null,

    /// A descriptive label that is associated with a fleet. Fleet names do not need
    /// to be unique.
    name: ?[]const u8 = null,

    /// The type of game session protection to set on all new instances that are
    /// started in
    /// the fleet. This attribute is used with fleets where `ComputeType` is
    /// `EC2`.
    ///
    /// * **NoProtection** -- The game session can be
    /// terminated during a scale-down event.
    ///
    /// * **FullProtection** -- If the game session is in an
    /// `ACTIVE` status, it cannot be terminated during a scale-down
    /// event.
    new_game_session_protection_policy: ?ProtectionPolicy = null,

    /// The operating system of the fleet's computing resources. A fleet's operating
    /// system is
    /// determined by the OS of the build or script that is deployed on this fleet.
    /// This
    /// attribute is used with fleets where `ComputeType` is
    /// `EC2`.
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

    /// Configuration settings for player gateway on this fleet.
    player_gateway_configuration: ?PlayerGatewayConfiguration = null,

    /// Indicates whether player gateway is enabled for this fleet. Player gateway
    /// provides benefits such as DDoS protection with negligible impact to latency.
    ///
    /// If `ENABLED` or `REQUIRED`, game clients can use player gateway to connect
    /// with the game server. If `DISABLED`, game clients cannot use player gateway.
    /// Instead, they have to directly connect to the game server.
    player_gateway_mode: ?PlayerGatewayMode = null,

    resource_creation_limit_policy: ?ResourceCreationLimitPolicy = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// associated with the GameLift script resource that is deployed on instances
    /// in this fleet. In a GameLift script ARN, the resource ID matches the
    /// `ScriptId` value.
    script_arn: ?[]const u8 = null,

    /// A unique identifier for the Realtime script resource that is deployed on
    /// instances in this fleet.
    /// This attribute is used with fleets where `ComputeType` is "EC2".
    script_id: ?[]const u8 = null,

    /// **This parameter is no longer used.** Server launch
    /// parameters are now defined using the fleet's runtime configuration. Requests
    /// that use
    /// this parameter continue to be valid.
    server_launch_parameters: ?[]const u8 = null,

    /// **This parameter is no longer used.** Server launch paths
    /// are now defined using the fleet's
    /// [RuntimeConfiguration](https://docs.aws.amazon.com/gamelift/latest/apireference/RuntimeConfiguration.html). Requests that use this parameter continue to be
    /// valid.
    server_launch_path: ?[]const u8 = null,

    /// Current status of the fleet. Possible fleet statuses include the following:
    ///
    /// * NEW -- A new fleet resource has been defined and Amazon GameLift Servers
    ///   has started creating the fleet.
    /// Desired instances is set to 1.
    ///
    /// * DOWNLOADING/VALIDATING/BUILDING -- Amazon GameLift Servers is download the
    ///   game server build,
    /// running install scripts, and then validating the build files. When complete,
    /// Amazon GameLift Servers launches a fleet instance.
    ///
    /// * ACTIVATING -- Amazon GameLift Servers is launching a game server process
    ///   and testing its
    /// connectivity with the Amazon GameLift Servers service.
    ///
    /// * ACTIVE -- The fleet is now ready to host game sessions.
    ///
    /// * ERROR -- An error occurred when downloading,
    /// validating, building, or activating the fleet.
    ///
    /// * DELETING -- Hosts are responding to a delete fleet request.
    ///
    /// * TERMINATED -- The fleet no longer exists.
    status: ?FleetStatus = null,

    /// A list of fleet activity that has been suspended using
    /// [StopFleetActions](https://docs.aws.amazon.com/gamelift/latest/apireference/API_StopFleetActions.html). This includes fleet auto-scaling. This attribute is used
    /// with fleets where `ComputeType` is `EC2`.
    stopped_actions: ?[]const FleetAction = null,

    /// A time stamp indicating when this data object was terminated. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    termination_time: ?i64 = null,

    pub const json_field_names = .{
        .anywhere_configuration = "AnywhereConfiguration",
        .build_arn = "BuildArn",
        .build_id = "BuildId",
        .certificate_configuration = "CertificateConfiguration",
        .compute_type = "ComputeType",
        .creation_time = "CreationTime",
        .description = "Description",
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .fleet_type = "FleetType",
        .instance_role_arn = "InstanceRoleArn",
        .instance_role_credentials_provider = "InstanceRoleCredentialsProvider",
        .instance_type = "InstanceType",
        .log_paths = "LogPaths",
        .metric_groups = "MetricGroups",
        .name = "Name",
        .new_game_session_protection_policy = "NewGameSessionProtectionPolicy",
        .operating_system = "OperatingSystem",
        .player_gateway_configuration = "PlayerGatewayConfiguration",
        .player_gateway_mode = "PlayerGatewayMode",
        .resource_creation_limit_policy = "ResourceCreationLimitPolicy",
        .script_arn = "ScriptArn",
        .script_id = "ScriptId",
        .server_launch_parameters = "ServerLaunchParameters",
        .server_launch_path = "ServerLaunchPath",
        .status = "Status",
        .stopped_actions = "StoppedActions",
        .termination_time = "TerminationTime",
    };
};
