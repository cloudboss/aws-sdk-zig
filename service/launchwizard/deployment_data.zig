const aws = @import("aws");

const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// The data associated with a deployment.
pub const DeploymentData = struct {
    /// The time the deployment was created.
    created_at: ?i64,

    /// The time the deployment was deleted.
    deleted_at: ?i64,

    /// The Amazon Resource Name (ARN) of the deployment.
    deployment_arn: ?[]const u8,

    /// The ID of the deployment.
    id: ?[]const u8,

    /// The time the deployment was last modified.
    modified_at: ?i64,

    /// The name of the deployment.
    name: ?[]const u8,

    /// The pattern name of the deployment.
    pattern_name: ?[]const u8,

    /// The resource group of the deployment.
    resource_group: ?[]const u8,

    /// The settings specified for the deployment. These settings define how to
    /// deploy and configure your resources created by the deployment. For more
    /// information about the specifications required for creating a deployment for
    /// a SAP workload, see [SAP deployment
    /// specifications](https://docs.aws.amazon.com/launchwizard/latest/APIReference/launch-wizard-specifications-sap.html). To retrieve the specifications required to create a deployment for other workloads, use the [ `GetWorkloadDeploymentPattern` ](https://docs.aws.amazon.com/launchwizard/latest/APIReference/API_GetWorkloadDeploymentPattern.html) operation.
    specifications: ?[]const aws.map.StringMapEntry,

    /// The status of the deployment.
    status: ?DeploymentStatus,

    /// Information about the tags attached to a deployment.
    tags: ?[]const aws.map.StringMapEntry,

    /// The name of the workload.
    workload_name: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .deleted_at = "deletedAt",
        .deployment_arn = "deploymentArn",
        .id = "id",
        .modified_at = "modifiedAt",
        .name = "name",
        .pattern_name = "patternName",
        .resource_group = "resourceGroup",
        .specifications = "specifications",
        .status = "status",
        .tags = "tags",
        .workload_name = "workloadName",
    };
};
