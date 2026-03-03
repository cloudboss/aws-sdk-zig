const CustomizedLoadMetricSpecification = @import("customized_load_metric_specification.zig").CustomizedLoadMetricSpecification;
const PredefinedLoadMetricSpecification = @import("predefined_load_metric_specification.zig").PredefinedLoadMetricSpecification;
const PredictiveScalingMaxCapacityBehavior = @import("predictive_scaling_max_capacity_behavior.zig").PredictiveScalingMaxCapacityBehavior;
const PredictiveScalingMode = @import("predictive_scaling_mode.zig").PredictiveScalingMode;
const ScalableDimension = @import("scalable_dimension.zig").ScalableDimension;
const ScalingPolicyUpdateBehavior = @import("scaling_policy_update_behavior.zig").ScalingPolicyUpdateBehavior;
const ServiceNamespace = @import("service_namespace.zig").ServiceNamespace;
const TargetTrackingConfiguration = @import("target_tracking_configuration.zig").TargetTrackingConfiguration;

/// Describes a scaling instruction for a scalable resource in a scaling plan.
/// Each scaling
/// instruction applies to one resource.
///
/// AWS Auto Scaling creates target tracking scaling policies based on the
/// scaling instructions.
/// Target tracking scaling policies adjust the capacity of your scalable
/// resource as required
/// to maintain resource utilization at the target value that you specified.
///
/// AWS Auto Scaling also configures predictive scaling for your Amazon EC2 Auto
/// Scaling groups using a subset of
/// parameters, including the load metric, the scaling metric, the target value
/// for the scaling
/// metric, the predictive scaling mode (forecast and scale or forecast only),
/// and the desired
/// behavior when the forecast capacity exceeds the maximum capacity of the
/// resource. With
/// predictive scaling, AWS Auto Scaling generates forecasts with traffic
/// predictions for the two days
/// ahead and schedules scaling actions that proactively add and remove resource
/// capacity to
/// match the forecast.
///
/// We recommend waiting a minimum of 24 hours after creating an Auto Scaling
/// group to configure
/// predictive scaling. At minimum, there must be 24 hours of historical data to
/// generate a
/// forecast. For more information, see [Best Practices for
/// AWS Auto
/// Scaling](https://docs.aws.amazon.com/autoscaling/plans/userguide/gs-best-practices.html) in the *AWS Auto Scaling User Guide*.
pub const ScalingInstruction = struct {
    /// The customized load metric to use for predictive scaling. This parameter or
    /// a **PredefinedLoadMetricSpecification** is required when configuring
    /// predictive scaling, and cannot be used otherwise.
    customized_load_metric_specification: ?CustomizedLoadMetricSpecification = null,

    /// Controls whether dynamic scaling by AWS Auto Scaling is disabled. When
    /// dynamic scaling is
    /// enabled, AWS Auto Scaling creates target tracking scaling policies based on
    /// the specified target
    /// tracking configurations.
    ///
    /// The default is enabled (`false`).
    disable_dynamic_scaling: ?bool = null,

    /// The maximum capacity of the resource. The exception to this upper limit is
    /// if you
    /// specify a non-default setting for **PredictiveScalingMaxCapacityBehavior**.
    max_capacity: i32,

    /// The minimum capacity of the resource.
    min_capacity: i32,

    /// The predefined load metric to use for predictive scaling. This parameter or
    /// a **CustomizedLoadMetricSpecification** is required when configuring
    /// predictive scaling, and cannot be used otherwise.
    predefined_load_metric_specification: ?PredefinedLoadMetricSpecification = null,

    /// Defines the behavior that should be applied if the forecast capacity
    /// approaches or
    /// exceeds the maximum capacity specified for the resource. The default value
    /// is
    /// `SetForecastCapacityToMaxCapacity`.
    ///
    /// The following are possible values:
    ///
    /// * `SetForecastCapacityToMaxCapacity` - AWS Auto Scaling cannot scale
    ///   resource
    /// capacity higher than the maximum capacity. The maximum capacity is enforced
    /// as a hard
    /// limit.
    ///
    /// * `SetMaxCapacityToForecastCapacity` - AWS Auto Scaling may scale resource
    /// capacity higher than the maximum capacity to equal but not exceed forecast
    /// capacity.
    ///
    /// * `SetMaxCapacityAboveForecastCapacity` - AWS Auto Scaling may scale
    ///   resource
    /// capacity higher than the maximum capacity by a specified buffer value. The
    /// intention
    /// is to give the target tracking scaling policy extra capacity if unexpected
    /// traffic
    /// occurs.
    ///
    /// Only valid when configuring predictive scaling.
    predictive_scaling_max_capacity_behavior: ?PredictiveScalingMaxCapacityBehavior = null,

    /// The size of the capacity buffer to use when the forecast capacity is close
    /// to or exceeds
    /// the maximum capacity. The value is specified as a percentage relative to the
    /// forecast
    /// capacity. For example, if the buffer is 10, this means a 10 percent buffer,
    /// such that if
    /// the forecast capacity is 50, and the maximum capacity is 40, then the
    /// effective maximum
    /// capacity is 55.
    ///
    /// Only valid when configuring predictive scaling. Required if the
    /// **PredictiveScalingMaxCapacityBehavior** is set to
    /// `SetMaxCapacityAboveForecastCapacity`, and cannot be used otherwise.
    ///
    /// The range is 1-100.
    predictive_scaling_max_capacity_buffer: ?i32 = null,

    /// The predictive scaling mode. The default value is `ForecastAndScale`.
    /// Otherwise, AWS Auto Scaling forecasts capacity but does not create any
    /// scheduled scaling actions
    /// based on the capacity forecast.
    predictive_scaling_mode: ?PredictiveScalingMode = null,

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

    /// The scalable dimension associated with the resource.
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

    /// Controls whether a resource's externally created scaling policies are kept
    /// or replaced.
    ///
    /// The default value is `KeepExternalPolicies`. If the parameter is set to
    /// `ReplaceExternalPolicies`, any scaling policies that are external to AWS
    /// Auto Scaling
    /// are deleted and new target tracking scaling policies created.
    ///
    /// Only valid when configuring dynamic scaling.
    ///
    /// Condition: The number of existing policies to be replaced must be less than
    /// or equal to
    /// 50. If there are more than 50 policies to be replaced, AWS Auto Scaling
    /// keeps all existing policies
    /// and does not create new ones.
    scaling_policy_update_behavior: ?ScalingPolicyUpdateBehavior = null,

    /// The amount of time, in seconds, to buffer the run time of scheduled scaling
    /// actions when
    /// scaling out. For example, if the forecast says to add capacity at 10:00 AM,
    /// and the buffer
    /// time is 5 minutes, then the run time of the corresponding scheduled scaling
    /// action will be
    /// 9:55 AM. The intention is to give resources time to be provisioned. For
    /// example, it can
    /// take a few minutes to launch an EC2 instance. The actual amount of time
    /// required depends on
    /// several factors, such as the size of the instance and whether there are
    /// startup scripts to
    /// complete.
    ///
    /// The value must be less than the forecast interval duration of 3600 seconds
    /// (60 minutes).
    /// The default is 300 seconds.
    ///
    /// Only valid when configuring predictive scaling.
    scheduled_action_buffer_time: ?i32 = null,

    /// The namespace of the AWS service.
    service_namespace: ServiceNamespace,

    /// The target tracking configurations (up to 10). Each of these structures must
    /// specify a
    /// unique scaling metric and a target value for the metric.
    target_tracking_configurations: []const TargetTrackingConfiguration,

    pub const json_field_names = .{
        .customized_load_metric_specification = "CustomizedLoadMetricSpecification",
        .disable_dynamic_scaling = "DisableDynamicScaling",
        .max_capacity = "MaxCapacity",
        .min_capacity = "MinCapacity",
        .predefined_load_metric_specification = "PredefinedLoadMetricSpecification",
        .predictive_scaling_max_capacity_behavior = "PredictiveScalingMaxCapacityBehavior",
        .predictive_scaling_max_capacity_buffer = "PredictiveScalingMaxCapacityBuffer",
        .predictive_scaling_mode = "PredictiveScalingMode",
        .resource_id = "ResourceId",
        .scalable_dimension = "ScalableDimension",
        .scaling_policy_update_behavior = "ScalingPolicyUpdateBehavior",
        .scheduled_action_buffer_time = "ScheduledActionBufferTime",
        .service_namespace = "ServiceNamespace",
        .target_tracking_configurations = "TargetTrackingConfigurations",
    };
};
