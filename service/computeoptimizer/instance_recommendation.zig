const GpuInfo = @import("gpu_info.zig").GpuInfo;
const CurrentPerformanceRisk = @import("current_performance_risk.zig").CurrentPerformanceRisk;
const EffectiveRecommendationPreferences = @import("effective_recommendation_preferences.zig").EffectiveRecommendationPreferences;
const ExternalMetricStatus = @import("external_metric_status.zig").ExternalMetricStatus;
const Finding = @import("finding.zig").Finding;
const InstanceRecommendationFindingReasonCode = @import("instance_recommendation_finding_reason_code.zig").InstanceRecommendationFindingReasonCode;
const InstanceIdle = @import("instance_idle.zig").InstanceIdle;
const InferredWorkloadType = @import("inferred_workload_type.zig").InferredWorkloadType;
const InstanceState = @import("instance_state.zig").InstanceState;
const InstanceRecommendationOption = @import("instance_recommendation_option.zig").InstanceRecommendationOption;
const RecommendationSource = @import("recommendation_source.zig").RecommendationSource;
const Tag = @import("tag.zig").Tag;
const UtilizationMetric = @import("utilization_metric.zig").UtilizationMetric;

/// Describes an Amazon EC2 instance recommendation.
pub const InstanceRecommendation = struct {
    /// The Amazon Web Services account ID of the instance.
    account_id: ?[]const u8 = null,

    /// Describes the GPU accelerator settings for the current instance type.
    current_instance_gpu_info: ?GpuInfo = null,

    /// The instance type of the current instance.
    current_instance_type: ?[]const u8 = null,

    /// The risk of the current instance not meeting the performance needs of its
    /// workloads.
    /// The higher the risk, the more likely the current instance cannot meet the
    /// performance
    /// requirements of its workload.
    current_performance_risk: ?CurrentPerformanceRisk = null,

    /// An object that describes the effective recommendation preferences for the
    /// instance.
    effective_recommendation_preferences: ?EffectiveRecommendationPreferences = null,

    /// An object that describes Compute Optimizer's integration status with your
    /// external metrics provider.
    external_metric_status: ?ExternalMetricStatus = null,

    /// The finding classification of the instance.
    ///
    /// Findings for instances include:
    ///
    /// * **
    /// `Underprovisioned`
    /// **—An instance is
    /// considered under-provisioned when at least one specification of your
    /// instance,
    /// such as CPU, memory, or network, does not meet the performance requirements
    /// of
    /// your workload. Under-provisioned instances may lead to poor application
    /// performance.
    ///
    /// * **
    /// `Overprovisioned`
    /// **—An instance is
    /// considered over-provisioned when at least one specification of your
    /// instance,
    /// such as CPU, memory, or network, can be sized down while still meeting the
    /// performance requirements of your workload, and no specification is
    /// under-provisioned. Over-provisioned instances may lead to unnecessary
    /// infrastructure cost.
    ///
    /// * **
    /// `Optimized`
    /// **—An instance is
    /// considered optimized when all specifications of your instance, such as CPU,
    /// memory, and network, meet the performance requirements of your workload and
    /// is
    /// not over provisioned. For optimized resources, Compute Optimizer might
    /// recommend a new generation instance type.
    ///
    /// The valid values in your API responses appear as OVER_PROVISIONED,
    /// UNDER_PROVISIONED, or OPTIMIZED.
    finding: ?Finding = null,

    /// The reason for the finding classification of the instance.
    ///
    /// Finding reason codes for instances include:
    ///
    /// * **
    /// `CPUOverprovisioned`
    /// ** — The
    /// instance’s CPU configuration can be sized down while still meeting the
    /// performance requirements of your workload. This is identified by analyzing
    /// the
    /// `CPUUtilization` metric of the current instance during the
    /// look-back period.
    ///
    /// * **
    /// `CPUUnderprovisioned`
    /// ** — The
    /// instance’s CPU configuration doesn't meet the performance requirements of
    /// your
    /// workload and there is an alternative instance type that provides better CPU
    /// performance. This is identified by analyzing the `CPUUtilization`
    /// metric of the current instance during the look-back period.
    ///
    /// * **
    /// `MemoryOverprovisioned`
    /// ** — The
    /// instance’s memory configuration can be sized down while still meeting the
    /// performance requirements of your workload. This is identified by analyzing
    /// the
    /// memory utilization metric of the current instance during the look-back
    /// period.
    ///
    /// * **
    /// `MemoryUnderprovisioned`
    /// ** — The
    /// instance’s memory configuration doesn't meet the performance requirements of
    /// your workload and there is an alternative instance type that provides better
    /// memory performance. This is identified by analyzing the memory utilization
    /// metric of the current instance during the look-back period.
    ///
    /// Memory utilization is analyzed only for resources that have the unified
    /// CloudWatch agent installed on them. For more information, see
    /// [Enabling memory
    /// utilization with the Amazon CloudWatch
    /// Agent](https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent) in the
    /// *Compute Optimizer User Guide*. On Linux
    /// instances, Compute Optimizer analyses the `mem_used_percent`
    /// metric in the `CWAgent` namespace, or the legacy
    /// `MemoryUtilization` metric in the `System/Linux`
    /// namespace. On Windows instances, Compute Optimizer analyses the `Memory
    /// % Committed Bytes In Use` metric in the `CWAgent`
    /// namespace.
    ///
    /// * **
    /// `EBSThroughputOverprovisioned`
    /// ** —
    /// The instance’s EBS throughput configuration can be sized down while still
    /// meeting the performance requirements of your workload. This is identified by
    /// analyzing the `VolumeReadBytes` and `VolumeWriteBytes` metrics
    /// of EBS volumes attached to the current instance during the look-back
    /// period.
    ///
    /// * **
    /// `EBSThroughputUnderprovisioned`
    /// ** —
    /// The instance’s EBS throughput configuration doesn't meet the performance
    /// requirements of your workload and there is an alternative instance type that
    /// provides better EBS throughput performance. This is identified by analyzing
    /// the
    /// `VolumeReadBytes` and `VolumeWriteBytes` metrics of EBS
    /// volumes attached to the current instance during the look-back period.
    ///
    /// * **
    /// `EBSIOPSOverprovisioned`
    /// ** — The
    /// instance’s EBS IOPS configuration can be sized down while still meeting the
    /// performance requirements of your workload. This is identified by analyzing
    /// the
    /// `VolumeReadOps` and `VolumeWriteOps` metric of EBS
    /// volumes attached to the current instance during the look-back period.
    ///
    /// * **
    /// `EBSIOPSUnderprovisioned`
    /// ** — The
    /// instance’s EBS IOPS configuration doesn't meet the performance requirements
    /// of
    /// your workload and there is an alternative instance type that provides better
    /// EBS
    /// IOPS performance. This is identified by analyzing the
    /// `VolumeReadOps` and `VolumeWriteOps` metric of EBS
    /// volumes attached to the current instance during the look-back period.
    ///
    /// * **
    /// `NetworkBandwidthOverprovisioned`
    /// **
    /// — The instance’s network bandwidth configuration can be sized down while
    /// still
    /// meeting the performance requirements of your workload. This is identified by
    /// analyzing the `NetworkIn` and `NetworkOut` metrics of the
    /// current instance during the look-back period.
    ///
    /// * **
    /// `NetworkBandwidthUnderprovisioned`
    /// **
    /// — The instance’s network bandwidth configuration doesn't meet the
    /// performance
    /// requirements of your workload and there is an alternative instance type that
    /// provides better network bandwidth performance. This is identified by
    /// analyzing
    /// the `NetworkIn` and `NetworkOut` metrics of the current
    /// instance during the look-back period. This finding reason happens when the
    /// `NetworkIn` or `NetworkOut` performance of an instance
    /// is impacted.
    ///
    /// * **
    /// `NetworkPPSOverprovisioned`
    /// ** — The
    /// instance’s network PPS (packets per second) configuration can be sized down
    /// while still meeting the performance requirements of your workload. This is
    /// identified by analyzing the `NetworkPacketsIn` and
    /// `NetworkPacketsIn` metrics of the current instance during the
    /// look-back period.
    ///
    /// * **
    /// `NetworkPPSUnderprovisioned`
    /// ** — The
    /// instance’s network PPS (packets per second) configuration doesn't meet the
    /// performance requirements of your workload and there is an alternative
    /// instance
    /// type that provides better network PPS performance. This is identified by
    /// analyzing the `NetworkPacketsIn` and `NetworkPacketsIn`
    /// metrics of the current instance during the look-back period.
    ///
    /// * **
    /// `DiskIOPSOverprovisioned`
    /// ** — The
    /// instance’s disk IOPS configuration can be sized down while still meeting the
    /// performance requirements of your workload. This is identified by analyzing
    /// the
    /// `DiskReadOps` and `DiskWriteOps` metrics of the
    /// current instance during the look-back period.
    ///
    /// * **
    /// `DiskIOPSUnderprovisioned`
    /// ** — The
    /// instance’s disk IOPS configuration doesn't meet the performance requirements
    /// of
    /// your workload and there is an alternative instance type that provides better
    /// disk IOPS performance. This is identified by analyzing the
    /// `DiskReadOps` and `DiskWriteOps` metrics of the
    /// current instance during the look-back period.
    ///
    /// * **
    /// `DiskThroughputOverprovisioned`
    /// ** —
    /// The instance’s disk throughput configuration can be sized down while still
    /// meeting the performance requirements of your workload. This is identified by
    /// analyzing the `DiskReadBytes` and `DiskWriteBytes` metrics
    /// of the current instance during the look-back period.
    ///
    /// * **
    /// `DiskThroughputUnderprovisioned`
    /// ** —
    /// The instance’s disk throughput configuration doesn't meet the performance
    /// requirements of your workload and there is an alternative instance type that
    /// provides better disk throughput performance. This is identified by analyzing
    /// the
    /// `DiskReadBytes` and `DiskWriteBytes` metrics of the
    /// current instance during the look-back period.
    ///
    /// For more information about instance metrics, see [List the
    /// available CloudWatch metrics for your
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/viewing_metrics_with_cloudwatch.html) in the
    /// *Amazon Elastic Compute Cloud User Guide*. For more information
    /// about EBS volume metrics, see [Amazon CloudWatch
    /// metrics for Amazon
    /// EBS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using_cloudwatch_ebs.html) in the *Amazon Elastic Compute Cloud
    /// User Guide*.
    finding_reason_codes: ?[]const InstanceRecommendationFindingReasonCode = null,

    /// Describes if an Amazon EC2 instance is idle.
    idle: ?InstanceIdle = null,

    /// The applications that might be running on the instance as inferred by
    /// Compute Optimizer.
    ///
    /// Compute Optimizer can infer if one of the following applications might be
    /// running on
    /// the instance:
    ///
    /// * `AmazonEmr` - Infers that Amazon EMR might be running on
    /// the instance.
    ///
    /// * `ApacheCassandra` - Infers that Apache Cassandra might be running
    /// on the instance.
    ///
    /// * `ApacheHadoop` - Infers that Apache Hadoop might be running on the
    /// instance.
    ///
    /// * `Memcached` - Infers that Memcached might be running on the
    /// instance.
    ///
    /// * `NGINX` - Infers that NGINX might be running on the
    /// instance.
    ///
    /// * `PostgreSql` - Infers that PostgreSQL might be running on the
    /// instance.
    ///
    /// * `Redis` - Infers that Redis might be running on the
    /// instance.
    ///
    /// * `Kafka` - Infers that Kafka might be running on the
    /// instance.
    ///
    /// * `SQLServer` - Infers that SQLServer might be running on the
    /// instance.
    inferred_workload_types: ?[]const InferredWorkloadType = null,

    /// The Amazon Resource Name (ARN) of the current instance.
    instance_arn: ?[]const u8 = null,

    /// The name of the current instance.
    instance_name: ?[]const u8 = null,

    /// The state of the instance when the recommendation was generated.
    instance_state: ?InstanceState = null,

    /// The timestamp of when the instance recommendation was last generated.
    last_refresh_timestamp: ?i64 = null,

    /// The number of days for which utilization metrics were analyzed for the
    /// instance.
    look_back_period_in_days: f64 = 0,

    /// An array of objects that describe the recommendation options for the
    /// instance.
    recommendation_options: ?[]const InstanceRecommendationOption = null,

    /// An array of objects that describe the source resource of the recommendation.
    recommendation_sources: ?[]const RecommendationSource = null,

    /// A list of tags assigned to your Amazon EC2 instance recommendations.
    tags: ?[]const Tag = null,

    /// An array of objects that describe the utilization metrics of the instance.
    utilization_metrics: ?[]const UtilizationMetric = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .current_instance_gpu_info = "currentInstanceGpuInfo",
        .current_instance_type = "currentInstanceType",
        .current_performance_risk = "currentPerformanceRisk",
        .effective_recommendation_preferences = "effectiveRecommendationPreferences",
        .external_metric_status = "externalMetricStatus",
        .finding = "finding",
        .finding_reason_codes = "findingReasonCodes",
        .idle = "idle",
        .inferred_workload_types = "inferredWorkloadTypes",
        .instance_arn = "instanceArn",
        .instance_name = "instanceName",
        .instance_state = "instanceState",
        .last_refresh_timestamp = "lastRefreshTimestamp",
        .look_back_period_in_days = "lookBackPeriodInDays",
        .recommendation_options = "recommendationOptions",
        .recommendation_sources = "recommendationSources",
        .tags = "tags",
        .utilization_metrics = "utilizationMetrics",
    };
};
