const CurrentPerformanceRisk = @import("current_performance_risk.zig").CurrentPerformanceRisk;
const ServiceConfiguration = @import("service_configuration.zig").ServiceConfiguration;
const ECSEffectiveRecommendationPreferences = @import("ecs_effective_recommendation_preferences.zig").ECSEffectiveRecommendationPreferences;
const ECSServiceRecommendationFinding = @import("ecs_service_recommendation_finding.zig").ECSServiceRecommendationFinding;
const ECSServiceRecommendationFindingReasonCode = @import("ecs_service_recommendation_finding_reason_code.zig").ECSServiceRecommendationFindingReasonCode;
const ECSServiceLaunchType = @import("ecs_service_launch_type.zig").ECSServiceLaunchType;
const ECSServiceRecommendationOption = @import("ecs_service_recommendation_option.zig").ECSServiceRecommendationOption;
const Tag = @import("tag.zig").Tag;
const ECSServiceUtilizationMetric = @import("ecs_service_utilization_metric.zig").ECSServiceUtilizationMetric;

/// Describes an Amazon ECS service recommendation.
pub const ECSServiceRecommendation = struct {
    /// The Amazon Web Services account ID of the Amazon ECS service.
    account_id: ?[]const u8 = null,

    /// The risk of the current Amazon ECS service not meeting the performance needs
    /// of its workloads.
    /// The higher the risk, the more likely the current service can't meet the
    /// performance
    /// requirements of its workload.
    current_performance_risk: ?CurrentPerformanceRisk = null,

    /// The configuration of the current Amazon ECS service.
    current_service_configuration: ?ServiceConfiguration = null,

    /// Describes the effective recommendation preferences for Amazon ECS services.
    effective_recommendation_preferences: ?ECSEffectiveRecommendationPreferences = null,

    /// The finding classification of an Amazon ECS service.
    ///
    /// Findings for Amazon ECS services include:
    ///
    /// * **
    /// `Underprovisioned`
    /// ** —
    /// When Compute Optimizer detects that there’s not enough memory or CPU, an
    /// Amazon ECS
    /// service is considered under-provisioned. An under-provisioned service might
    /// result in poor application performance.
    ///
    /// * **
    /// `Overprovisioned`
    /// ** —
    /// When Compute Optimizer detects that there’s excessive memory or CPU, an
    /// Amazon ECS
    /// service is considered over-provisioned. An over-provisioned service might
    /// result in additional infrastructure costs.
    ///
    /// * **
    /// `Optimized`
    /// ** —
    /// When both the CPU and memory of your Amazon ECS service meet the performance
    /// requirements
    /// of your workload, the service is considered optimized.
    finding: ?ECSServiceRecommendationFinding = null,

    /// The reason for the finding classification of an Amazon ECS service.
    ///
    /// Finding reason codes for Amazon ECS services include:
    ///
    /// * **
    /// `CPUUnderprovisioned`
    /// ** —
    /// The service CPU configuration can be sized up to enhance the performance of
    /// your workload. This is identified by analyzing the `CPUUtilization` metric
    /// of the
    /// current service during the look-back period.
    ///
    /// * **
    /// `CPUOverprovisioned`
    /// ** —
    /// The service CPU configuration can be sized down while still meeting the
    /// performance
    /// requirements of your workload. This is identified by analyzing the
    /// `CPUUtilization`
    /// metric of the current service during the look-back period.
    ///
    /// * **
    /// `MemoryUnderprovisioned`
    /// ** —
    /// The service memory configuration can be sized up to enhance the performance
    /// of
    /// your workload. This is identified by analyzing the `MemoryUtilization`
    /// metric of the
    /// current service during the look-back period.
    ///
    /// * **
    /// `MemoryOverprovisioned`
    /// ** —
    /// The service memory configuration can be sized down while still meeting the
    /// performance requirements of your workload. This is identified by analyzing
    /// the
    /// `MemoryUtilization` metric of the current service during the look-back
    /// period.
    finding_reason_codes: ?[]const ECSServiceRecommendationFindingReasonCode = null,

    /// The timestamp of when the Amazon ECS service recommendation was last
    /// generated.
    last_refresh_timestamp: ?i64 = null,

    /// The launch type the Amazon ECS service is using.
    ///
    /// Compute Optimizer only supports the Fargate launch type.
    launch_type: ?ECSServiceLaunchType = null,

    /// The number of days the Amazon ECS service utilization metrics were analyzed.
    lookback_period_in_days: f64 = 0,

    /// The Amazon Resource Name (ARN) of the current Amazon ECS service.
    ///
    /// The following is the format of the ARN:
    ///
    /// `arn:aws:ecs:region:aws_account_id:service/cluster-name/service-name`
    service_arn: ?[]const u8 = null,

    /// An array of objects that describe the recommendation options for the Amazon
    /// ECS service.
    service_recommendation_options: ?[]const ECSServiceRecommendationOption = null,

    /// A list of tags assigned to your Amazon ECS service recommendations.
    tags: ?[]const Tag = null,

    /// An array of objects that describe the utilization metrics of the Amazon ECS
    /// service.
    utilization_metrics: ?[]const ECSServiceUtilizationMetric = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .current_performance_risk = "currentPerformanceRisk",
        .current_service_configuration = "currentServiceConfiguration",
        .effective_recommendation_preferences = "effectiveRecommendationPreferences",
        .finding = "finding",
        .finding_reason_codes = "findingReasonCodes",
        .last_refresh_timestamp = "lastRefreshTimestamp",
        .launch_type = "launchType",
        .lookback_period_in_days = "lookbackPeriodInDays",
        .service_arn = "serviceArn",
        .service_recommendation_options = "serviceRecommendationOptions",
        .tags = "tags",
        .utilization_metrics = "utilizationMetrics",
    };
};
