const SwitchoverDetail = @import("switchover_detail.zig").SwitchoverDetail;
const Tag = @import("tag.zig").Tag;
const BlueGreenDeploymentTask = @import("blue_green_deployment_task.zig").BlueGreenDeploymentTask;

/// Details about a blue/green deployment.
///
/// For more information, see [Using Amazon RDS Blue/Green Deployments for
/// database
/// updates](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/blue-green-deployments.html) in the *Amazon RDS User Guide* and [Using Amazon RDS Blue/Green Deployments for database updates](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/blue-green-deployments.html) in the *Amazon Aurora User Guide*.
pub const BlueGreenDeployment = struct {
    /// The unique identifier of the blue/green deployment.
    blue_green_deployment_identifier: ?[]const u8 = null,

    /// The user-supplied name of the blue/green deployment.
    blue_green_deployment_name: ?[]const u8 = null,

    /// The time when the blue/green deployment was created, in Universal
    /// Coordinated Time (UTC).
    create_time: ?i64 = null,

    /// The time when the blue/green deployment was deleted, in Universal
    /// Coordinated Time (UTC).
    delete_time: ?i64 = null,

    /// The source database for the blue/green deployment.
    ///
    /// Before switchover, the source database is the production database in the
    /// blue environment.
    source: ?[]const u8 = null,

    /// The status of the blue/green deployment.
    ///
    /// Valid Values:
    ///
    /// * `PROVISIONING` - Resources are being created in the green environment.
    /// * `AVAILABLE` - Resources are available in the green environment.
    /// * `SWITCHOVER_IN_PROGRESS` - The deployment is being switched from the blue
    ///   environment to the green environment.
    /// * `SWITCHOVER_COMPLETED` - Switchover from the blue environment to the green
    ///   environment is complete.
    /// * `INVALID_CONFIGURATION` - Resources in the green environment are invalid,
    ///   so switchover isn't possible.
    /// * `SWITCHOVER_FAILED` - Switchover was attempted but failed.
    /// * `DELETING` - The blue/green deployment is being deleted.
    status: ?[]const u8 = null,

    /// Additional information about the status of the blue/green deployment.
    status_details: ?[]const u8 = null,

    /// The details about each source and target resource in the blue/green
    /// deployment.
    switchover_details: ?[]const SwitchoverDetail = null,

    tag_list: ?[]const Tag = null,

    /// The target database for the blue/green deployment.
    ///
    /// Before switchover, the target database is the clone database in the green
    /// environment.
    target: ?[]const u8 = null,

    /// Either tasks to be performed or tasks that have been completed on the target
    /// database before switchover.
    tasks: ?[]const BlueGreenDeploymentTask = null,
};
