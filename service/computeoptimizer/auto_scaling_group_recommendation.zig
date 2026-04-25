const AutoScalingGroupConfiguration = @import("auto_scaling_group_configuration.zig").AutoScalingGroupConfiguration;
const GpuInfo = @import("gpu_info.zig").GpuInfo;
const CurrentPerformanceRisk = @import("current_performance_risk.zig").CurrentPerformanceRisk;
const EffectiveRecommendationPreferences = @import("effective_recommendation_preferences.zig").EffectiveRecommendationPreferences;
const Finding = @import("finding.zig").Finding;
const InferredWorkloadType = @import("inferred_workload_type.zig").InferredWorkloadType;
const AutoScalingGroupRecommendationOption = @import("auto_scaling_group_recommendation_option.zig").AutoScalingGroupRecommendationOption;
const UtilizationMetric = @import("utilization_metric.zig").UtilizationMetric;

/// Describes an Auto Scaling group recommendation.
pub const AutoScalingGroupRecommendation = struct {
    /// The Amazon Web Services account ID of the Auto Scaling group.
    account_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Auto Scaling group.
    auto_scaling_group_arn: ?[]const u8 = null,

    /// The name of the Auto Scaling group.
    auto_scaling_group_name: ?[]const u8 = null,

    /// An array of objects that describe the current configuration of the Auto
    /// Scaling
    /// group.
    current_configuration: ?AutoScalingGroupConfiguration = null,

    /// Describes the GPU accelerator settings for the current instance type of the
    /// Auto Scaling group.
    current_instance_gpu_info: ?GpuInfo = null,

    /// The risk of the current Auto Scaling group not meeting the performance needs
    /// of
    /// its workloads. The higher the risk, the more likely the current Auto Scaling
    /// group
    /// configuration has insufficient capacity and cannot meet workload
    /// requirements.
    current_performance_risk: ?CurrentPerformanceRisk = null,

    /// An object that describes the effective recommendation preferences for the
    /// Auto Scaling group.
    effective_recommendation_preferences: ?EffectiveRecommendationPreferences = null,

    /// The finding classification of the Auto Scaling group.
    ///
    /// Findings for Auto Scaling groups include:
    ///
    /// * **
    /// `NotOptimized`
    /// **—An Auto Scaling group is considered not optimized when Compute Optimizer
    /// identifies a
    /// recommendation that can provide better performance for your workload.
    ///
    /// * **
    /// `Optimized`
    /// **—An Auto Scaling
    /// group is considered optimized when Compute Optimizer determines that the
    /// group
    /// is correctly provisioned to run your workload based on the chosen instance
    /// type.
    /// For optimized resources, Compute Optimizer might recommend a new generation
    /// instance type.
    finding: ?Finding = null,

    /// The applications that might be running on the instances in the Auto Scaling
    /// group
    /// as inferred by Compute Optimizer.
    ///
    /// Compute Optimizer can infer if one of the following applications might be
    /// running on
    /// the instances:
    ///
    /// * `AmazonEmr` - Infers that Amazon EMR might be running on
    /// the instances.
    ///
    /// * `ApacheCassandra` - Infers that Apache Cassandra might be running
    /// on the instances.
    ///
    /// * `ApacheHadoop` - Infers that Apache Hadoop might be running on the
    /// instances.
    ///
    /// * `Memcached` - Infers that Memcached might be running on the
    /// instances.
    ///
    /// * `NGINX` - Infers that NGINX might be running on the
    /// instances.
    ///
    /// * `PostgreSql` - Infers that PostgreSQL might be running on the
    /// instances.
    ///
    /// * `Redis` - Infers that Redis might be running on the
    /// instances.
    ///
    /// * `Kafka` - Infers that Kafka might be running on the
    /// instance.
    ///
    /// * `SQLServer` - Infers that SQLServer might be running on the
    /// instance.
    inferred_workload_types: ?[]const InferredWorkloadType = null,

    /// The timestamp of when the Auto Scaling group recommendation was last
    /// generated.
    last_refresh_timestamp: ?i64 = null,

    /// The number of days for which utilization metrics were analyzed for the Auto
    /// Scaling group.
    look_back_period_in_days: f64 = 0,

    /// An array of objects that describe the recommendation options for the Auto
    /// Scaling
    /// group.
    recommendation_options: ?[]const AutoScalingGroupRecommendationOption = null,

    /// An array of objects that describe the utilization metrics of the Auto
    /// Scaling
    /// group.
    utilization_metrics: ?[]const UtilizationMetric = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .auto_scaling_group_arn = "autoScalingGroupArn",
        .auto_scaling_group_name = "autoScalingGroupName",
        .current_configuration = "currentConfiguration",
        .current_instance_gpu_info = "currentInstanceGpuInfo",
        .current_performance_risk = "currentPerformanceRisk",
        .effective_recommendation_preferences = "effectiveRecommendationPreferences",
        .finding = "finding",
        .inferred_workload_types = "inferredWorkloadTypes",
        .last_refresh_timestamp = "lastRefreshTimestamp",
        .look_back_period_in_days = "lookBackPeriodInDays",
        .recommendation_options = "recommendationOptions",
        .utilization_metrics = "utilizationMetrics",
    };
};
