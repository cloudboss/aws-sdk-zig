const AutoScalingGroupConfiguration = @import("auto_scaling_group_configuration.zig").AutoScalingGroupConfiguration;
const GpuInfo = @import("gpu_info.zig").GpuInfo;
const MigrationEffort = @import("migration_effort.zig").MigrationEffort;
const UtilizationMetric = @import("utilization_metric.zig").UtilizationMetric;
const SavingsOpportunity = @import("savings_opportunity.zig").SavingsOpportunity;
const AutoScalingGroupSavingsOpportunityAfterDiscounts = @import("auto_scaling_group_savings_opportunity_after_discounts.zig").AutoScalingGroupSavingsOpportunityAfterDiscounts;

/// Describes a recommendation option for an Amazon EC2 Auto Scaling group.
pub const AutoScalingGroupRecommendationOption = struct {
    /// An array of objects that describe an Amazon EC2 Auto Scaling group
    /// configuration.
    configuration: ?AutoScalingGroupConfiguration = null,

    /// Describes the GPU accelerator settings for the recommended instance type of
    /// the Amazon EC2 Auto Scaling group.
    instance_gpu_info: ?GpuInfo = null,

    /// The level of effort required to migrate from the current instance type to
    /// the
    /// recommended instance type.
    ///
    /// For example, the migration effort is `Low` if Amazon EMR is the
    /// inferred workload type and an Amazon Web Services Graviton instance type is
    /// recommended.
    /// The migration effort is `Medium` if a workload type couldn't be inferred but
    /// an Amazon Web Services Graviton instance type is recommended. The migration
    /// effort is
    /// `VeryLow` if both the current and recommended instance types are of the
    /// same CPU architecture.
    migration_effort: ?MigrationEffort = null,

    /// The performance risk of the Amazon EC2 Auto Scaling group configuration
    /// recommendation.
    ///
    /// Performance risk indicates the likelihood of the recommended instance type
    /// not meeting
    /// the resource needs of your workload. Compute Optimizer calculates an
    /// individual
    /// performance risk score for each specification of the recommended instance,
    /// including
    /// CPU, memory, EBS throughput, EBS IOPS, disk throughput, disk IOPS, network
    /// throughput,
    /// and network PPS.
    /// The performance
    /// risk of the recommended instance is calculated as the maximum performance
    /// risk score
    /// across the analyzed resource specifications.
    ///
    /// The value ranges from `0` - `4`, with `0` meaning
    /// that the recommended resource is predicted to always provide enough hardware
    /// capability.
    /// The higher the performance risk is, the more likely you should validate
    /// whether the
    /// recommendation will meet the performance requirements of your workload
    /// before migrating
    /// your resource.
    performance_risk: f64 = 0,

    /// An array of objects that describe the projected utilization metrics of the
    /// Amazon EC2 Auto Scaling group recommendation option.
    ///
    /// The `Cpu` and `Memory` metrics are the only projected
    /// utilization metrics returned. Additionally, the `Memory` metric is
    /// returned only for resources that have the unified CloudWatch agent installed
    /// on them. For more information, see [Enabling Memory
    /// Utilization with the CloudWatch
    /// Agent](https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent).
    projected_utilization_metrics: ?[]const UtilizationMetric = null,

    /// The rank of the Amazon EC2 Auto Scaling group recommendation option.
    ///
    /// The top recommendation option is ranked as `1`.
    rank: i32 = 0,

    /// An object that describes the savings opportunity for the Amazon EC2 Auto
    /// Scaling group
    /// recommendation option. Savings opportunity includes the estimated monthly
    /// savings amount
    /// and percentage.
    savings_opportunity: ?SavingsOpportunity = null,

    /// An object that describes the savings opportunity for the Amazon EC2 Auto
    /// Scaling group recommendation option that includes Savings Plans and Reserved
    /// Instances discounts.
    /// Savings opportunity includes the estimated monthly savings and percentage.
    savings_opportunity_after_discounts: ?AutoScalingGroupSavingsOpportunityAfterDiscounts = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .instance_gpu_info = "instanceGpuInfo",
        .migration_effort = "migrationEffort",
        .performance_risk = "performanceRisk",
        .projected_utilization_metrics = "projectedUtilizationMetrics",
        .rank = "rank",
        .savings_opportunity = "savingsOpportunity",
        .savings_opportunity_after_discounts = "savingsOpportunityAfterDiscounts",
    };
};
