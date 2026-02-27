const FreeTrialFeatureResult = @import("free_trial_feature_result.zig").FreeTrialFeatureResult;

/// Contains information about the free trial period for a feature.
pub const FreeTrialFeatureConfigurationResult = struct {
    /// The number of the remaining free trial days for the feature.
    free_trial_days_remaining: ?i32,

    /// The name of the feature for which the free trial is configured.
    name: ?FreeTrialFeatureResult,

    pub const json_field_names = .{
        .free_trial_days_remaining = "FreeTrialDaysRemaining",
        .name = "Name",
    };
};
