const RDSCurrentInstancePerformanceRisk = @import("rds_current_instance_performance_risk.zig").RDSCurrentInstancePerformanceRisk;
const DBStorageConfiguration = @import("db_storage_configuration.zig").DBStorageConfiguration;
const RDSEstimatedMonthlyVolumeIOPsCostVariation = @import("rds_estimated_monthly_volume_io_ps_cost_variation.zig").RDSEstimatedMonthlyVolumeIOPsCostVariation;
const RDSEffectiveRecommendationPreferences = @import("rds_effective_recommendation_preferences.zig").RDSEffectiveRecommendationPreferences;
const Idle = @import("idle.zig").Idle;
const RDSInstanceFinding = @import("rds_instance_finding.zig").RDSInstanceFinding;
const RDSInstanceFindingReasonCode = @import("rds_instance_finding_reason_code.zig").RDSInstanceFindingReasonCode;
const RDSDBInstanceRecommendationOption = @import("rdsdb_instance_recommendation_option.zig").RDSDBInstanceRecommendationOption;
const RDSStorageFinding = @import("rds_storage_finding.zig").RDSStorageFinding;
const RDSStorageFindingReasonCode = @import("rds_storage_finding_reason_code.zig").RDSStorageFindingReasonCode;
const RDSDBStorageRecommendationOption = @import("rdsdb_storage_recommendation_option.zig").RDSDBStorageRecommendationOption;
const Tag = @import("tag.zig").Tag;
const RDSDBUtilizationMetric = @import("rdsdb_utilization_metric.zig").RDSDBUtilizationMetric;

/// Describes an Amazon Aurora and RDS database recommendation.
pub const RDSDBRecommendation = struct {
    /// The Amazon Web Services account ID of the Amazon Aurora or RDS database.
    account_id: ?[]const u8,

    /// The DB instance class of the current Aurora or RDS DB instance.
    current_db_instance_class: ?[]const u8,

    /// The performance risk for the current DB instance.
    current_instance_performance_risk: ?RDSCurrentInstancePerformanceRisk,

    /// The configuration of the current DB storage.
    current_storage_configuration: ?DBStorageConfiguration,

    /// The level of variation in monthly I/O costs for the current DB storage
    /// configuration.
    current_storage_estimated_monthly_volume_io_ps_cost_variation: ?RDSEstimatedMonthlyVolumeIOPsCostVariation,

    /// The identifier for DB cluster.
    db_cluster_identifier: ?[]const u8,

    /// Describes the effective recommendation preferences for DB instances.
    effective_recommendation_preferences: ?RDSEffectiveRecommendationPreferences,

    /// The engine of the DB instance.
    engine: ?[]const u8,

    /// The database engine version.
    engine_version: ?[]const u8,

    /// This indicates if the DB instance is idle or not.
    idle: ?Idle,

    /// The finding classification of an Amazon Aurora and RDS DB instance.
    ///
    /// For more information about finding classifications, see [
    /// Finding classifications for Aurora and RDS
    /// databases](https://docs.aws.amazon.com/compute-optimizer/latest/ug/view-rds-recommendations.html#rds-recommendations-findings) in the *Compute Optimizer User
    /// Guide*.
    instance_finding: ?RDSInstanceFinding,

    /// The reason for the finding classification of a DB instance.
    instance_finding_reason_codes: ?[]const RDSInstanceFindingReasonCode,

    /// An array of objects that describe the recommendation options for the RDS DB
    /// instance.
    instance_recommendation_options: ?[]const RDSDBInstanceRecommendationOption,

    /// The timestamp of when the DB instance recommendation was last generated.
    last_refresh_timestamp: ?i64,

    /// The number of days the DB instance utilization metrics were analyzed.
    lookback_period_in_days: f64 = 0,

    /// The promotion tier for the Aurora instance.
    promotion_tier: ?i32,

    /// The ARN of the current Amazon Aurora or RDS database.
    ///
    /// The following is the format of the ARN:
    ///
    /// `arn:aws:rds:{region}:{accountId}:db:{resourceName}`
    resource_arn: ?[]const u8,

    /// The finding classification of Amazon RDS DB instance storage.
    ///
    /// For more information about finding classifications, see [
    /// Finding classifications for Aurora and RDS
    /// databases](https://docs.aws.amazon.com/compute-optimizer/latest/ug/view-rds-recommendations.html#rds-recommendations-findings) in the *Compute Optimizer User
    /// Guide*.
    storage_finding: ?RDSStorageFinding,

    /// The reason for the finding classification of RDS DB instance storage.
    storage_finding_reason_codes: ?[]const RDSStorageFindingReasonCode,

    /// An array of objects that describe the recommendation options for DB instance
    /// storage.
    storage_recommendation_options: ?[]const RDSDBStorageRecommendationOption,

    /// A list of tags assigned to your DB instance recommendations.
    tags: ?[]const Tag,

    /// An array of objects that describe the utilization metrics of the DB
    /// instance.
    utilization_metrics: ?[]const RDSDBUtilizationMetric,

    pub const json_field_names = .{
        .account_id = "accountId",
        .current_db_instance_class = "currentDBInstanceClass",
        .current_instance_performance_risk = "currentInstancePerformanceRisk",
        .current_storage_configuration = "currentStorageConfiguration",
        .current_storage_estimated_monthly_volume_io_ps_cost_variation = "currentStorageEstimatedMonthlyVolumeIOPsCostVariation",
        .db_cluster_identifier = "dbClusterIdentifier",
        .effective_recommendation_preferences = "effectiveRecommendationPreferences",
        .engine = "engine",
        .engine_version = "engineVersion",
        .idle = "idle",
        .instance_finding = "instanceFinding",
        .instance_finding_reason_codes = "instanceFindingReasonCodes",
        .instance_recommendation_options = "instanceRecommendationOptions",
        .last_refresh_timestamp = "lastRefreshTimestamp",
        .lookback_period_in_days = "lookbackPeriodInDays",
        .promotion_tier = "promotionTier",
        .resource_arn = "resourceArn",
        .storage_finding = "storageFinding",
        .storage_finding_reason_codes = "storageFindingReasonCodes",
        .storage_recommendation_options = "storageRecommendationOptions",
        .tags = "tags",
        .utilization_metrics = "utilizationMetrics",
    };
};
