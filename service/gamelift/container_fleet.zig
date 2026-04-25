const ContainerFleetBillingType = @import("container_fleet_billing_type.zig").ContainerFleetBillingType;
const DeploymentDetails = @import("deployment_details.zig").DeploymentDetails;
const GameSessionCreationLimitPolicy = @import("game_session_creation_limit_policy.zig").GameSessionCreationLimitPolicy;
const ConnectionPortRange = @import("connection_port_range.zig").ConnectionPortRange;
const IpPermission = @import("ip_permission.zig").IpPermission;
const ContainerFleetLocationAttributes = @import("container_fleet_location_attributes.zig").ContainerFleetLocationAttributes;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const ProtectionPolicy = @import("protection_policy.zig").ProtectionPolicy;
const PlayerGatewayMode = @import("player_gateway_mode.zig").PlayerGatewayMode;
const ContainerFleetStatus = @import("container_fleet_status.zig").ContainerFleetStatus;

/// Describes an Amazon GameLift Servers managed container fleet.
pub const ContainerFleet = struct {
    /// Indicates whether the fleet uses On-Demand or Spot instances for this fleet.
    /// Learn
    /// more about when to use [ On-Demand versus Spot
    /// Instances](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-ec2-instances.html#gamelift-ec2-instances-spot). You can't update this fleet
    /// property.
    ///
    /// By default, this property is set to `ON_DEMAND`.
    billing_type: ?ContainerFleetBillingType = null,

    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64 = null,

    /// Information about the most recent deployment for the container fleet.
    deployment_details: ?DeploymentDetails = null,

    /// A meaningful description of the container fleet.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers fleet resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::fleet/fleet-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`. In a
    /// GameLift fleet ARN, the resource ID matches the `FleetId`
    /// value.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the container fleet to retrieve.
    fleet_id: ?[]const u8 = null,

    /// The unique identifier for an Identity and Access Management (IAM) role with
    /// permissions to run your
    /// containers on resources that are managed by Amazon GameLift Servers. See
    /// [Set up an IAM service
    /// role](https://docs.aws.amazon.com/gamelift/latest/developerguide/setting-up-role.html). This fleet property can't be changed.
    fleet_role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to the fleet's game server container group. The ARN value
    /// also identifies the specific container group definition version in use.
    game_server_container_group_definition_arn: ?[]const u8 = null,

    /// The name of the fleet's game server container group definition, which
    /// describes how to
    /// deploy containers with your game server build and support software onto each
    /// fleet
    /// instance.
    game_server_container_group_definition_name: ?[]const u8 = null,

    /// The number of times to replicate the game server container group on each
    /// fleet
    /// instance.
    game_server_container_groups_per_instance: ?i32 = null,

    /// A policy that limits the number of game sessions that each individual player
    /// can create
    /// on instances in this fleet. The limit applies for a specified span of time.
    game_session_creation_limit_policy: ?GameSessionCreationLimitPolicy = null,

    instance_connection_port_range: ?ConnectionPortRange = null,

    /// The IP address ranges and port settings that allow inbound traffic to access
    /// game
    /// server processes and other processes on this fleet.
    instance_inbound_permissions: ?[]const IpPermission = null,

    /// The Amazon EC2 instance type to use for all instances in the fleet. Instance
    /// type
    /// determines the computing resources and processing power that's available to
    /// host your
    /// game servers. This includes including CPU, memory, storage, and networking
    /// capacity. You
    /// can't update this fleet property.
    instance_type: ?[]const u8 = null,

    /// Information about the container fleet's remote locations where fleet
    /// instances are
    /// deployed.
    location_attributes: ?[]const ContainerFleetLocationAttributes = null,

    /// The method that is used to collect container logs for the fleet. Amazon
    /// GameLift Servers saves all
    /// standard output for each container in logs, including game session logs.
    ///
    /// * `CLOUDWATCH` -- Send logs to an Amazon CloudWatch log group that you
    ///   define. Each container
    /// emits a log stream, which is organized in the log group.
    ///
    /// * `S3` -- Store logs in an Amazon S3 bucket that you define.
    ///
    /// * `NONE` -- Don't collect container logs.
    log_configuration: ?LogConfiguration = null,

    /// The calculated maximum number of game server container group that can be
    /// deployed on
    /// each fleet instance. The calculation depends on the resource needs of the
    /// container
    /// group and the CPU and memory resources of the fleet's instance type.
    maximum_game_server_container_groups_per_instance: ?i32 = null,

    /// The name of an Amazon Web Services CloudWatch metric group to add this fleet
    /// to. Metric groups
    /// aggregate metrics for multiple fleets.
    metric_groups: ?[]const []const u8 = null,

    /// Determines whether Amazon GameLift Servers can shut down game sessions on
    /// the fleet that are actively
    /// running and hosting players. Amazon GameLift Servers might prompt an
    /// instance shutdown when scaling down
    /// fleet capacity or when retiring unhealthy instances. You can also set game
    /// session
    /// protection for individual game sessions using
    /// [UpdateGameSession](gamelift/latest/apireference/API_UpdateGameSession.html).
    ///
    /// * **NoProtection** -- Game sessions can be shut down
    /// during active gameplay.
    ///
    /// * **FullProtection** -- Game sessions in
    /// `ACTIVE` status can't be shut down.
    new_game_session_protection_policy: ?ProtectionPolicy = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to the fleet's per-instance container group. The ARN value
    /// also identifies the specific container group definition version in use.
    per_instance_container_group_definition_arn: ?[]const u8 = null,

    /// The name of the fleet's per-instance container group definition.
    per_instance_container_group_definition_name: ?[]const u8 = null,

    /// Indicates whether player gateway is enabled for this container fleet. Player
    /// gateway provides benefits such as DDoS protection with negligible impact to
    /// latency.
    ///
    /// If `ENABLED` or `REQUIRED`, game clients can use player gateway to connect
    /// with the game server. If `DISABLED`, game clients cannot use player gateway.
    /// Instead, they have to directly connect to the game server.
    player_gateway_mode: ?PlayerGatewayMode = null,

    /// The current status of the container fleet.
    ///
    /// * `PENDING` -- A new container fleet has been requested.
    ///
    /// * `CREATING` -- A new container fleet resource is being created.
    ///
    /// * `CREATED` -- A new container fleet resource has been created. No fleet
    ///   instances
    /// have been deployed.
    ///
    /// * `ACTIVATING` -- New container fleet instances are being deployed.
    ///
    /// * `ACTIVE` -- The container fleet has been deployed and is ready to host
    ///   game
    /// sessions.
    ///
    /// * `UPDATING` -- Updates to the container fleet is being updated. A
    ///   deployment is in
    /// progress.
    status: ?ContainerFleetStatus = null,

    pub const json_field_names = .{
        .billing_type = "BillingType",
        .creation_time = "CreationTime",
        .deployment_details = "DeploymentDetails",
        .description = "Description",
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .fleet_role_arn = "FleetRoleArn",
        .game_server_container_group_definition_arn = "GameServerContainerGroupDefinitionArn",
        .game_server_container_group_definition_name = "GameServerContainerGroupDefinitionName",
        .game_server_container_groups_per_instance = "GameServerContainerGroupsPerInstance",
        .game_session_creation_limit_policy = "GameSessionCreationLimitPolicy",
        .instance_connection_port_range = "InstanceConnectionPortRange",
        .instance_inbound_permissions = "InstanceInboundPermissions",
        .instance_type = "InstanceType",
        .location_attributes = "LocationAttributes",
        .log_configuration = "LogConfiguration",
        .maximum_game_server_container_groups_per_instance = "MaximumGameServerContainerGroupsPerInstance",
        .metric_groups = "MetricGroups",
        .new_game_session_protection_policy = "NewGameSessionProtectionPolicy",
        .per_instance_container_group_definition_arn = "PerInstanceContainerGroupDefinitionArn",
        .per_instance_container_group_definition_name = "PerInstanceContainerGroupDefinitionName",
        .player_gateway_mode = "PlayerGatewayMode",
        .status = "Status",
    };
};
