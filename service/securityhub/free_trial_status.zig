const FreeTrialType = @import("free_trial_type.zig").FreeTrialType;
const FreeTrialStatusValue = @import("free_trial_status_value.zig").FreeTrialStatusValue;

/// The free trial period for a Security Hub feature, and whether the trial is
/// currently active.
pub const FreeTrialStatus = struct {
    /// The date and time at which the free trial period ends.
    expires_at: i64,

    /// The feature that the free trial period applies to. Valid values:
    ///
    /// * `SECURITY_HUB_V2` specifies Security Hub.
    ///
    /// * `SECURITY_HUB_V2_MULTI_CLOUD_AZURE` specifies Security Hub coverage for
    ///   Microsoft Azure resources.
    feature_type: FreeTrialType,

    /// The date and time at which the free trial period began.
    started_at: i64,

    /// Specifies whether the free trial period is currently active. Valid values:
    ///
    /// * `ACTIVE` specifies that the free trial period is ongoing.
    ///
    /// * `INACTIVE` specifies that the free trial period has ended, or that it
    ///   never started.
    ///
    /// To determine whether a trial has expired, compare `ExpiresAt` to the current
    /// time.
    status: FreeTrialStatusValue,

    pub const json_field_names = .{
        .expires_at = "ExpiresAt",
        .feature_type = "FeatureType",
        .started_at = "StartedAt",
        .status = "Status",
    };
};
