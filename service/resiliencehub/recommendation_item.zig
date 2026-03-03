const Alarm = @import("alarm.zig").Alarm;
const ExcludeRecommendationReason = @import("exclude_recommendation_reason.zig").ExcludeRecommendationReason;
const Experiment = @import("experiment.zig").Experiment;

/// Defines a recommendation.
pub const RecommendationItem = struct {
    /// Specifies if the recommendation has already been implemented.
    already_implemented: ?bool = null,

    /// Indicates the previously implemented Amazon CloudWatch alarm discovered by
    /// Resilience Hub.
    discovered_alarm: ?Alarm = null,

    /// Indicates if an operational recommendation item is excluded.
    excluded: ?bool = null,

    /// Indicates the reason for excluding an operational recommendation.
    exclude_reason: ?ExcludeRecommendationReason = null,

    /// Indicates the experiment created in FIS that was discovered by Resilience
    /// Hub, which matches the recommendation.
    latest_discovered_experiment: ?Experiment = null,

    /// Identifier of the resource.
    resource_id: ?[]const u8 = null,

    /// Identifier of the target account.
    target_account_id: ?[]const u8 = null,

    /// The target region.
    target_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .already_implemented = "alreadyImplemented",
        .discovered_alarm = "discoveredAlarm",
        .excluded = "excluded",
        .exclude_reason = "excludeReason",
        .latest_discovered_experiment = "latestDiscoveredExperiment",
        .resource_id = "resourceId",
        .target_account_id = "targetAccountId",
        .target_region = "targetRegion",
    };
};
