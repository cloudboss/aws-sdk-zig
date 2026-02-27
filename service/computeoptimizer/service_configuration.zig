const AutoScalingConfiguration = @import("auto_scaling_configuration.zig").AutoScalingConfiguration;
const ContainerConfiguration = @import("container_configuration.zig").ContainerConfiguration;

/// The Amazon ECS service configurations used for recommendations.
pub const ServiceConfiguration = struct {
    /// Describes the Auto Scaling configuration methods for an Amazon ECS service.
    /// This affects
    /// the generated recommendations. For example, if Auto Scaling is configured on
    /// a
    /// service’s CPU, then Compute Optimizer doesn’t generate CPU size
    /// recommendations.
    ///
    /// The Auto Scaling configuration methods include:
    ///
    /// * `TARGET_TRACKING_SCALING_CPU` — If the Amazon ECS service is configured
    /// to use target scaling on CPU, Compute Optimizer doesn't generate CPU
    /// recommendations.
    ///
    /// * `TARGET_TRACKING_SCALING_MEMORY` — If the Amazon ECS service is configured
    /// to use target scaling on memory, Compute Optimizer doesn't generate memory
    /// recommendations.
    ///
    /// For more information about step scaling and target scaling, see
    /// [
    /// Step scaling policies for Application Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-step-scaling-policies.html) and
    /// [
    /// Target tracking scaling policies for Application Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-target-tracking.html) in the
    /// *Application Auto Scaling User Guide*.
    auto_scaling_configuration: ?AutoScalingConfiguration,

    /// The container configurations within a task of an Amazon ECS service.
    container_configurations: ?[]const ContainerConfiguration,

    /// The number of CPU units used by the tasks in the Amazon ECS service.
    cpu: ?i32,

    /// The amount of memory used by the tasks in the Amazon ECS service.
    memory: ?i32,

    /// The task definition ARN used by the tasks in the Amazon ECS service.
    task_definition_arn: ?[]const u8,

    pub const json_field_names = .{
        .auto_scaling_configuration = "autoScalingConfiguration",
        .container_configurations = "containerConfigurations",
        .cpu = "cpu",
        .memory = "memory",
        .task_definition_arn = "taskDefinitionArn",
    };
};
