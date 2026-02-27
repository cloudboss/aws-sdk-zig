/// Information about a CodeDeploy deployment that occurred around the time of
/// an
/// incident and could be a possible cause of the incident.
pub const CodeDeployDeployment = struct {
    /// The Amazon Resource Name (ARN) of the CodeDeploy deployment group associated
    /// with
    /// the deployment.
    deployment_group_arn: []const u8,

    /// The ID of the CodeDeploy deployment.
    deployment_id: []const u8,

    /// The timestamp for when the CodeDeploy deployment ended. Not reported for
    /// deployments that are still in progress.
    end_time: ?i64,

    /// The timestamp for when the CodeDeploy deployment began.
    start_time: i64,

    pub const json_field_names = .{
        .deployment_group_arn = "deploymentGroupArn",
        .deployment_id = "deploymentId",
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
