const CurrentPerformanceRisk = @import("current_performance_risk.zig").CurrentPerformanceRisk;
const LambdaEffectiveRecommendationPreferences = @import("lambda_effective_recommendation_preferences.zig").LambdaEffectiveRecommendationPreferences;
const LambdaFunctionRecommendationFinding = @import("lambda_function_recommendation_finding.zig").LambdaFunctionRecommendationFinding;
const LambdaFunctionRecommendationFindingReasonCode = @import("lambda_function_recommendation_finding_reason_code.zig").LambdaFunctionRecommendationFindingReasonCode;
const LambdaFunctionMemoryRecommendationOption = @import("lambda_function_memory_recommendation_option.zig").LambdaFunctionMemoryRecommendationOption;
const Tag = @import("tag.zig").Tag;
const LambdaFunctionUtilizationMetric = @import("lambda_function_utilization_metric.zig").LambdaFunctionUtilizationMetric;

/// Describes an Lambda function recommendation.
pub const LambdaFunctionRecommendation = struct {
    /// The Amazon Web Services account ID of the function.
    account_id: ?[]const u8 = null,

    /// The amount of memory, in MB, that's allocated to the current function.
    current_memory_size: i32 = 0,

    /// The risk of the current Lambda function not meeting the performance needs
    /// of its workloads. The higher the risk, the more likely the current Lambda
    /// function requires more memory.
    current_performance_risk: ?CurrentPerformanceRisk = null,

    /// Describes the effective recommendation preferences for Lambda functions.
    effective_recommendation_preferences: ?LambdaEffectiveRecommendationPreferences = null,

    /// The finding classification of the function.
    ///
    /// Findings for functions include:
    ///
    /// * **
    /// `Optimized`
    /// ** — The function is
    /// correctly provisioned to run your workload based on its current
    /// configuration
    /// and its utilization history. This finding classification does not include
    /// finding reason codes.
    ///
    /// * **
    /// `NotOptimized`
    /// ** — The function is
    /// performing at a higher level (over-provisioned) or at a lower level
    /// (under-provisioned) than required for your workload because its current
    /// configuration is not optimal. Over-provisioned resources might lead to
    /// unnecessary infrastructure cost, and under-provisioned resources might lead
    /// to
    /// poor application performance. This finding classification can include the
    /// `MemoryUnderprovisioned` and `MemoryUnderprovisioned`
    /// finding reason codes.
    ///
    /// * **
    /// `Unavailable`
    /// ** — Compute Optimizer
    /// was unable to generate a recommendation for the function. This could be
    /// because
    /// the function has not accumulated sufficient metric data, or the function
    /// does
    /// not qualify for a recommendation. This finding classification can include
    /// the
    /// `InsufficientData` and `Inconclusive` finding reason
    /// codes.
    ///
    /// Functions with a finding of unavailable are not returned unless you
    /// specify the `filter` parameter with a value of
    /// `Unavailable` in your
    /// `GetLambdaFunctionRecommendations` request.
    finding: ?LambdaFunctionRecommendationFinding = null,

    /// The reason for the finding classification of the function.
    ///
    /// Functions that have a finding classification of `Optimized` don't have
    /// a finding reason code.
    ///
    /// Finding reason codes for functions include:
    ///
    /// * **
    /// `MemoryOverprovisioned`
    /// ** — The
    /// function is over-provisioned when its memory configuration can be sized down
    /// while still meeting the performance requirements of your workload. An
    /// over-provisioned function might lead to unnecessary infrastructure cost.
    /// This
    /// finding reason code is part of the `NotOptimized` finding
    /// classification.
    ///
    /// * **
    /// `MemoryUnderprovisioned`
    /// ** — The
    /// function is under-provisioned when its memory configuration doesn't meet the
    /// performance requirements of the workload. An under-provisioned function
    /// might
    /// lead to poor application performance. This finding reason code is part of
    /// the
    /// `NotOptimized` finding classification.
    ///
    /// * **
    /// `InsufficientData`
    /// ** — The function
    /// does not have sufficient metric data for Compute Optimizer to generate a
    /// recommendation. For more information, see the [Supported resources and
    /// requirements](https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html) in the *Compute Optimizer User
    /// Guide*. This finding reason code is part of the
    /// `Unavailable` finding classification.
    ///
    /// * **
    /// `Inconclusive`
    /// ** — The function does
    /// not qualify for a recommendation because Compute Optimizer cannot generate a
    /// recommendation with a high degree of confidence. This finding reason code is
    /// part of the `Unavailable` finding classification.
    finding_reason_codes: ?[]const LambdaFunctionRecommendationFindingReasonCode = null,

    /// The Amazon Resource Name (ARN) of the current function.
    function_arn: ?[]const u8 = null,

    /// The version number of the current function.
    function_version: ?[]const u8 = null,

    /// The timestamp of when the function recommendation was last generated.
    last_refresh_timestamp: ?i64 = null,

    /// The number of days for which utilization metrics were analyzed for the
    /// function.
    lookback_period_in_days: f64 = 0,

    /// An array of objects that describe the memory configuration recommendation
    /// options for
    /// the function.
    memory_size_recommendation_options: ?[]const LambdaFunctionMemoryRecommendationOption = null,

    /// The number of times your function code was applied during the look-back
    /// period.
    number_of_invocations: i64 = 0,

    /// A list of tags assigned to your Lambda function recommendations.
    tags: ?[]const Tag = null,

    /// An array of objects that describe the utilization metrics of the function.
    utilization_metrics: ?[]const LambdaFunctionUtilizationMetric = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .current_memory_size = "currentMemorySize",
        .current_performance_risk = "currentPerformanceRisk",
        .effective_recommendation_preferences = "effectiveRecommendationPreferences",
        .finding = "finding",
        .finding_reason_codes = "findingReasonCodes",
        .function_arn = "functionArn",
        .function_version = "functionVersion",
        .last_refresh_timestamp = "lastRefreshTimestamp",
        .lookback_period_in_days = "lookbackPeriodInDays",
        .memory_size_recommendation_options = "memorySizeRecommendationOptions",
        .number_of_invocations = "numberOfInvocations",
        .tags = "tags",
        .utilization_metrics = "utilizationMetrics",
    };
};
