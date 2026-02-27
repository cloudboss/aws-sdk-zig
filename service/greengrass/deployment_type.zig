/// The type of deployment. When used for ''CreateDeployment'', only
/// ''NewDeployment'' and ''Redeployment'' are valid.
pub const DeploymentType = enum {
    new_deployment,
    redeployment,
    reset_deployment,
    force_reset_deployment,

    pub const json_field_names = .{
        .new_deployment = "NewDeployment",
        .redeployment = "Redeployment",
        .reset_deployment = "ResetDeployment",
        .force_reset_deployment = "ForceResetDeployment",
    };
};
