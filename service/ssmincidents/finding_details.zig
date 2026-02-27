const CloudFormationStackUpdate = @import("cloud_formation_stack_update.zig").CloudFormationStackUpdate;
const CodeDeployDeployment = @import("code_deploy_deployment.zig").CodeDeployDeployment;

/// Extended textual information about the finding.
pub const FindingDetails = union(enum) {
    /// Information about the CloudFormation stack creation or update associated
    /// with the
    /// finding.
    cloud_formation_stack_update: ?CloudFormationStackUpdate,
    /// Information about the CodeDeploy deployment associated with the finding.
    code_deploy_deployment: ?CodeDeployDeployment,

    pub const json_field_names = .{
        .cloud_formation_stack_update = "cloudFormationStackUpdate",
        .code_deploy_deployment = "codeDeployDeployment",
    };
};
