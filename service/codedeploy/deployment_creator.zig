pub const DeploymentCreator = enum {
    user,
    autoscaling,
    code_deploy_rollback,
    code_deploy,
    code_deploy_auto_update,
    cloud_formation,
    cloud_formation_rollback,
    autoscaling_termination,

    pub const json_field_names = .{
        .user = "User",
        .autoscaling = "Autoscaling",
        .code_deploy_rollback = "CodeDeployRollback",
        .code_deploy = "CodeDeploy",
        .code_deploy_auto_update = "CodeDeployAutoUpdate",
        .cloud_formation = "CloudFormation",
        .cloud_formation_rollback = "CloudFormationRollback",
        .autoscaling_termination = "AutoscalingTermination",
    };
};
