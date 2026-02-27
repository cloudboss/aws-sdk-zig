/// Information about the deployment controller type that the service uses.
pub const AwsEcsServiceDeploymentControllerDetails = struct {
    /// The rolling update (`ECS`) deployment type replaces the current running
    /// version of the container with the latest version.
    ///
    /// The blue/green (`CODE_DEPLOY`) deployment type uses the blue/green
    /// deployment model that is powered by CodeDeploy. This deployment model a new
    /// deployment of a service can be verified before production traffic is sent to
    /// it.
    ///
    /// The external (`EXTERNAL`) deployment type allows the use of any third-party
    /// deployment controller for full control over the deployment process for an
    /// Amazon ECS service.
    ///
    /// Valid values: `ECS` | `CODE_DEPLOY` | `EXTERNAL`
    type: ?[]const u8,

    pub const json_field_names = .{
        .type = "Type",
    };
};
