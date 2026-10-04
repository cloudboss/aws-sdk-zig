const AggregationStatusEnum = @import("aggregation_status_enum.zig").AggregationStatusEnum;
const ApplicationStatusReason = @import("application_status_reason.zig").ApplicationStatusReason;
const ApplicationStatusCheckEnum = @import("application_status_check_enum.zig").ApplicationStatusCheckEnum;

/// Describes the details of an application status check for an instance.
pub const ApplicationStatusDetail = struct {
    /// The aggregation setting for the application status check. When set to
    /// `included`, the result of this check contributes to the instance-level
    /// application status. When set to `excluded`, the check runs independently and
    /// does not affect the instance-level status.
    aggregation: ?AggregationStatusEnum = null,

    /// The ID of the application status check.
    application_status_check_id: ?[]const u8 = null,

    /// The date and time when the check was last updated.
    check_update_time: ?i64 = null,

    /// The reason for the current status.
    reason: ?ApplicationStatusReason = null,

    /// The status of the individual application status check. Possible values:
    ///
    /// * `passed` – The check reached its success threshold.
    ///
    /// * `failed` – The check reached its failure threshold.
    ///
    /// * `initializing` – The check is initializing or has not reached a success or
    ///   failure threshold.
    ///
    /// * `insufficient-data` – The check does not have enough data to determine a
    ///   result.
    ///
    /// * `not-applicable` – The check does not apply to the instance.
    ///
    /// This value reflects the check result and is not affected by aggregation or
    /// suppression.
    status: ?ApplicationStatusCheckEnum = null,

    /// The date and time when the current status started for this check.
    status_since: ?i64 = null,

    /// The date and time of the last status update for this check.
    status_time_stamp: ?i64 = null,
};
