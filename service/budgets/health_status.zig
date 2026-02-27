const HealthStatusValue = @import("health_status_value.zig").HealthStatusValue;
const HealthStatusReason = @import("health_status_reason.zig").HealthStatusReason;

/// Provides information about the current operational state of a billing view
/// resource,
/// including its ability to access and update based on its associated billing
/// view.
pub const HealthStatus = struct {
    last_updated_time: ?i64,

    /// The current status of the billing view resource.
    status: ?HealthStatusValue,

    /// The reason for the current status.
    ///
    /// * `BILLING_VIEW_NO_ACCESS`: The billing view resource does not grant
    /// `billing:GetBillingViewData` permission to this account.
    ///
    /// * `BILLING_VIEW_UNHEALTHY`: The billing view associated with the
    /// budget is unhealthy.
    ///
    /// * `FILTER_INVALID`: The filter contains reference to an account you
    /// do not have access to.
    ///
    /// * `MULTI_YEAR_HISTORICAL_DATA_DISABLED`: The budget is not being updated.
    ///   Enable multi-year historical data in your Cost Management preferences.
    status_reason: ?HealthStatusReason,

    pub const json_field_names = .{
        .last_updated_time = "LastUpdatedTime",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};
