const CloudFormationTarget = @import("cloud_formation_target.zig").CloudFormationTarget;
const DeploymentTargetType = @import("deployment_target_type.zig").DeploymentTargetType;
const ECSTarget = @import("ecs_target.zig").ECSTarget;
const InstanceTarget = @import("instance_target.zig").InstanceTarget;
const LambdaTarget = @import("lambda_target.zig").LambdaTarget;

/// Information about the deployment target.
pub const DeploymentTarget = struct {
    cloud_formation_target: ?CloudFormationTarget = null,

    /// The deployment type that is specific to the deployment's compute platform or
    /// deployments initiated by a CloudFormation stack update.
    deployment_target_type: ?DeploymentTargetType = null,

    /// Information about the target for a deployment that uses the Amazon ECS
    /// compute platform.
    ecs_target: ?ECSTarget = null,

    /// Information about the target for a deployment that uses the EC2/On-premises
    /// compute
    /// platform.
    instance_target: ?InstanceTarget = null,

    /// Information about the target for a deployment that uses the Lambda
    /// compute platform.
    lambda_target: ?LambdaTarget = null,

    pub const json_field_names = .{
        .cloud_formation_target = "cloudFormationTarget",
        .deployment_target_type = "deploymentTargetType",
        .ecs_target = "ecsTarget",
        .instance_target = "instanceTarget",
        .lambda_target = "lambdaTarget",
    };
};
