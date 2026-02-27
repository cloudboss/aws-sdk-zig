const ScalableDimension = @import("scalable_dimension.zig").ScalableDimension;
const ScalingPolicy = @import("scaling_policy.zig").ScalingPolicy;
const ScalingStatusCode = @import("scaling_status_code.zig").ScalingStatusCode;
const ServiceNamespace = @import("service_namespace.zig").ServiceNamespace;

/// Represents a scalable resource.
pub const ScalingPlanResource = struct {
    /// The ID of the resource. This string consists of the resource type and unique
    /// identifier.
    ///
    /// * Auto Scaling group - The resource type is `autoScalingGroup` and the
    ///   unique identifier is the
    /// name of the Auto Scaling group. Example: `autoScalingGroup/my-asg`.
    ///
    /// * ECS service - The resource type is `service` and the unique identifier is
    ///   the cluster name
    /// and service name. Example: `service/default/sample-webapp`.
    ///
    /// * Spot Fleet request - The resource type is `spot-fleet-request` and the
    ///   unique identifier is the
    /// Spot Fleet request ID. Example:
    /// `spot-fleet-request/sfr-73fbd2ce-aa30-494c-8788-1cee4EXAMPLE`.
    ///
    /// * DynamoDB table - The resource type is `table` and the unique identifier is
    ///   the resource ID.
    /// Example: `table/my-table`.
    ///
    /// * DynamoDB global secondary index - The resource type is `index` and the
    ///   unique identifier is the resource ID.
    /// Example: `table/my-table/index/my-table-index`.
    ///
    /// * Aurora DB cluster - The resource type is `cluster` and the unique
    ///   identifier is the cluster name.
    /// Example: `cluster:my-db-cluster`.
    resource_id: []const u8,

    /// The scalable dimension for the resource.
    ///
    /// * `autoscaling:autoScalingGroup:DesiredCapacity` - The desired capacity of
    ///   an Auto Scaling group.
    ///
    /// * `ecs:service:DesiredCount` - The desired task count of an ECS service.
    ///
    /// * `ec2:spot-fleet-request:TargetCapacity` - The target capacity of a Spot
    ///   Fleet request.
    ///
    /// * `dynamodb:table:ReadCapacityUnits` - The provisioned read capacity for a
    ///   DynamoDB table.
    ///
    /// * `dynamodb:table:WriteCapacityUnits` - The provisioned write capacity for a
    ///   DynamoDB table.
    ///
    /// * `dynamodb:index:ReadCapacityUnits` - The provisioned read capacity for a
    ///   DynamoDB global secondary index.
    ///
    /// * `dynamodb:index:WriteCapacityUnits` - The provisioned write capacity for a
    ///   DynamoDB global secondary index.
    ///
    /// * `rds:cluster:ReadReplicaCount` - The count of Aurora Replicas in an Aurora
    ///   DB cluster. Available for Aurora MySQL-compatible edition and Aurora
    ///   PostgreSQL-compatible edition.
    scalable_dimension: ScalableDimension,

    /// The name of the scaling plan.
    scaling_plan_name: []const u8,

    /// The version number of the scaling plan.
    scaling_plan_version: i64,

    /// The scaling policies.
    scaling_policies: ?[]const ScalingPolicy,

    /// The scaling status of the resource.
    ///
    /// * `Active` - The scaling configuration is active.
    ///
    /// * `Inactive` - The scaling configuration is not active because the
    /// scaling plan is being created or the scaling configuration could not be
    /// applied.
    /// Check the status message for more information.
    ///
    /// * `PartiallyActive` - The scaling configuration is partially active
    /// because the scaling plan is being created or deleted or the scaling
    /// configuration
    /// could not be fully applied. Check the status message for more information.
    scaling_status_code: ScalingStatusCode,

    /// A simple message about the current scaling status of the resource.
    scaling_status_message: ?[]const u8,

    /// The namespace of the AWS service.
    service_namespace: ServiceNamespace,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .scalable_dimension = "ScalableDimension",
        .scaling_plan_name = "ScalingPlanName",
        .scaling_plan_version = "ScalingPlanVersion",
        .scaling_policies = "ScalingPolicies",
        .scaling_status_code = "ScalingStatusCode",
        .scaling_status_message = "ScalingStatusMessage",
        .service_namespace = "ServiceNamespace",
    };
};
