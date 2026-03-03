/// Results of a dry run performed in an update domain request.
pub const DryRunResults = struct {
    /// Specifies the way in which OpenSearch Service will apply an update. Possible
    /// values
    /// are:
    ///
    /// * **Blue/Green** - The update requires a blue/green
    /// deployment.
    ///
    /// * **DynamicUpdate** - No blue/green deployment
    /// required
    ///
    /// * **Undetermined** - The domain is in the middle of
    /// an update and can't predict the deployment type. Try again after the update
    /// is
    /// complete.
    ///
    /// * **None** - The request doesn't include any
    /// configuration changes.
    deployment_type: ?[]const u8 = null,

    /// A message corresponding to the deployment type.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_type = "DeploymentType",
        .message = "Message",
    };
};
