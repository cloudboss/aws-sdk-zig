/// Details about a task for a blue/green deployment.
///
/// For more information, see [Using Amazon RDS Blue/Green Deployments for
/// database
/// updates](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/blue-green-deployments.html) in the *Amazon RDS User Guide* and [Using Amazon RDS Blue/Green Deployments for database updates](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/blue-green-deployments.html) in the *Amazon Aurora User Guide*.
pub const BlueGreenDeploymentTask = struct {
    /// The name of the blue/green deployment task.
    name: ?[]const u8 = null,

    /// The status of the blue/green deployment task.
    ///
    /// Valid Values:
    ///
    /// * `PENDING` - The resource is being prepared for deployment.
    /// * `IN_PROGRESS` - The resource is being deployed.
    /// * `COMPLETED` - The resource has been deployed.
    /// * `FAILED` - Deployment of the resource failed.
    status: ?[]const u8 = null,
};
