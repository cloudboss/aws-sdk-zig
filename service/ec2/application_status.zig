const ApplicationStatusDetail = @import("application_status_detail.zig").ApplicationStatusDetail;
const ApplicationStatusEnum = @import("application_status_enum.zig").ApplicationStatusEnum;

/// Describes the application-level health status for an instance.
pub const ApplicationStatus = struct {
    /// Details about the application status checks for the instance.
    details: ?[]const ApplicationStatusDetail = null,

    /// The date and time when application status reporting resumes after
    /// suppression.
    resume_at: ?i64 = null,

    /// The current instance-level application status. This status is derived from
    /// application status checks with `Aggregation` set to `included`. Possible
    /// values:
    ///
    /// * `ok` – All included checks passed.
    ///
    /// * `impaired` – At least one included check failed.
    ///
    /// * `initializing` – At least one included check is initializing, and no
    ///   included check is impaired.
    ///
    /// * `insufficient-data` – At least one included check has insufficient data,
    ///   and no included check is impaired or initializing.
    ///
    /// * `not-applicable` – No checks with `Aggregation` set to `included` apply to
    ///   the instance.
    ///
    /// * `suppressed` – Application status reporting is suppressed for the
    ///   instance.
    ///
    /// Checks with `Aggregation` set to `excluded` do not affect this value.
    status: ?ApplicationStatusEnum = null,

    /// The date and time when the current status started.
    status_since: ?i64 = null,

    /// The date and time of the last status update.
    status_time_stamp: ?i64 = null,
};
