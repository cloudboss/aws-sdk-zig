const VolumeConfiguration = @import("volume_configuration.zig").VolumeConfiguration;
const CurrentPerformanceRisk = @import("current_performance_risk.zig").CurrentPerformanceRisk;
const EBSEffectiveRecommendationPreferences = @import("ebs_effective_recommendation_preferences.zig").EBSEffectiveRecommendationPreferences;
const EBSFinding = @import("ebs_finding.zig").EBSFinding;
const Tag = @import("tag.zig").Tag;
const EBSUtilizationMetric = @import("ebs_utilization_metric.zig").EBSUtilizationMetric;
const VolumeRecommendationOption = @import("volume_recommendation_option.zig").VolumeRecommendationOption;

/// Describes an Amazon Elastic Block Store (Amazon EBS) volume recommendation.
pub const VolumeRecommendation = struct {
    /// The Amazon Web Services account ID of the volume.
    account_id: ?[]const u8 = null,

    /// An array of objects that describe the current configuration of the volume.
    current_configuration: ?VolumeConfiguration = null,

    /// The risk of the current EBS volume not meeting the performance needs of its
    /// workloads.
    /// The higher the risk, the more likely the current EBS volume doesn't have
    /// sufficient
    /// capacity.
    current_performance_risk: ?CurrentPerformanceRisk = null,

    /// Describes the effective recommendation preferences for Amazon EBS volume.
    effective_recommendation_preferences: ?EBSEffectiveRecommendationPreferences = null,

    /// The finding classification of the volume.
    ///
    /// Findings for volumes include:
    ///
    /// * **
    /// `NotOptimized`
    /// **—A volume is
    /// considered not optimized when Compute Optimizer identifies a recommendation
    /// that can provide better performance for your workload.
    ///
    /// * **
    /// `Optimized`
    /// **—An volume is
    /// considered optimized when Compute Optimizer determines that the volume is
    /// correctly provisioned to run your workload based on the chosen volume type.
    /// For
    /// optimized resources, Compute Optimizer might recommend a new generation
    /// volume
    /// type.
    finding: ?EBSFinding = null,

    /// The timestamp of when the volume recommendation was last generated.
    last_refresh_timestamp: ?i64 = null,

    /// The number of days for which utilization metrics were analyzed for the
    /// volume.
    look_back_period_in_days: f64 = 0,

    /// A list of tags assigned to your Amazon EBS volume recommendations.
    tags: ?[]const Tag = null,

    /// An array of objects that describe the utilization metrics of the volume.
    utilization_metrics: ?[]const EBSUtilizationMetric = null,

    /// The Amazon Resource Name (ARN) of the current volume.
    volume_arn: ?[]const u8 = null,

    /// An array of objects that describe the recommendation options for the volume.
    volume_recommendation_options: ?[]const VolumeRecommendationOption = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .current_configuration = "currentConfiguration",
        .current_performance_risk = "currentPerformanceRisk",
        .effective_recommendation_preferences = "effectiveRecommendationPreferences",
        .finding = "finding",
        .last_refresh_timestamp = "lastRefreshTimestamp",
        .look_back_period_in_days = "lookBackPeriodInDays",
        .tags = "tags",
        .utilization_metrics = "utilizationMetrics",
        .volume_arn = "volumeArn",
        .volume_recommendation_options = "volumeRecommendationOptions",
    };
};
