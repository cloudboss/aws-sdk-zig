const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// Describes a container fleet deployment with updates to the fleet.
pub const FleetDeployment = struct {
    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64,

    /// Instructions for how to deploy updates to a container fleet and what actions
    /// to take
    /// if the deployment fails.
    deployment_configuration: ?DeploymentConfiguration,

    /// A unique identifier for the deployment.
    deployment_id: ?[]const u8,

    /// The status of fleet deployment activity in the location.
    ///
    /// * `IN_PROGRESS` -- The deployment is in progress.
    ///
    /// * `IMPAIRED` -- The deployment failed and the fleet has some impaired
    /// containers.
    ///
    /// * `COMPLETE` -- The deployment has completed successfully.
    ///
    /// * `ROLLBACK_IN_PROGRESS` -- The deployment failed and rollback has
    /// been initiated.
    ///
    /// * `ROLLBACK_IN_COMPLETE` -- The deployment failed and rollback has
    /// been completed.
    ///
    /// * `CANCELLED` -- The deployment was cancelled.
    deployment_status: ?DeploymentStatus,

    /// A unique identifier for the container fleet.
    fleet_id: ?[]const u8,

    /// The unique identifier for the version of the game server container group
    /// definition
    /// that is being deployed.
    game_server_binary_arn: ?[]const u8,

    /// The unique identifier for the version of the per-instance container group
    /// definition
    /// that is being deployed.
    per_instance_binary_arn: ?[]const u8,

    /// The unique identifier for the version of the game server container group
    /// definition to
    /// roll back to if deployment fails. Amazon GameLift Servers sets this property
    /// to the container group definition
    /// version that the fleet used when it was last active.
    rollback_game_server_binary_arn: ?[]const u8,

    /// The unique identifier for the version of the per-instance container group
    /// definition
    /// to roll back to if deployment fails. Amazon GameLift Servers sets this
    /// property to the container group definition
    /// version that the fleet used when it was last active.
    rollback_per_instance_binary_arn: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .deployment_configuration = "DeploymentConfiguration",
        .deployment_id = "DeploymentId",
        .deployment_status = "DeploymentStatus",
        .fleet_id = "FleetId",
        .game_server_binary_arn = "GameServerBinaryArn",
        .per_instance_binary_arn = "PerInstanceBinaryArn",
        .rollback_game_server_binary_arn = "RollbackGameServerBinaryArn",
        .rollback_per_instance_binary_arn = "RollbackPerInstanceBinaryArn",
    };
};
