/// Contains the details about a blue/green deployment.
///
/// For more information, see [Using Amazon RDS Blue/Green Deployments for
/// database
/// updates](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/blue-green-deployments.html) in the *Amazon RDS User Guide* and [Using Amazon RDS Blue/Green Deployments for database updates](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/blue-green-deployments.html) in the *Amazon Aurora User Guide*.
pub const SwitchoverDetail = struct {
    /// The Amazon Resource Name (ARN) of a resource in the blue environment.
    source_member: ?[]const u8,

    /// The switchover status of a resource in a blue/green deployment.
    ///
    /// Values:
    ///
    /// * `PROVISIONING` - The resource is being prepared to switch over.
    /// * `AVAILABLE` - The resource is ready to switch over.
    /// * `SWITCHOVER_IN_PROGRESS` - The resource is being switched over.
    /// * `SWITCHOVER_COMPLETED` - The resource has been switched over.
    /// * `SWITCHOVER_FAILED` - The resource attempted to switch over but failed.
    /// * `MISSING_SOURCE` - The source resource has been deleted.
    /// * `MISSING_TARGET` - The target resource has been deleted.
    status: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a resource in the green environment.
    target_member: ?[]const u8,
};
