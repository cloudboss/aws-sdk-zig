const EcrPullDateRescanDuration = @import("ecr_pull_date_rescan_duration.zig").EcrPullDateRescanDuration;
const EcrPullDateRescanMode = @import("ecr_pull_date_rescan_mode.zig").EcrPullDateRescanMode;
const EcrRescanDuration = @import("ecr_rescan_duration.zig").EcrRescanDuration;
const EcrRescanDurationStatus = @import("ecr_rescan_duration_status.zig").EcrRescanDurationStatus;

/// Details about the state of your ECR re-scan duration settings. The ECR
/// re-scan duration
/// defines how long an ECR image will be actively scanned by Amazon Inspector.
/// When the number of days
/// since an image was last pushed exceeds the duration configured for image
/// pull date, and the
/// duration configured for image pull date, the monitoring state of that image
/// becomes
/// `inactive` and all associated findings are scheduled for closure.
pub const EcrRescanDurationState = struct {
    /// The rescan duration configured for image pull date.
    pull_date_rescan_duration: ?EcrPullDateRescanDuration = null,

    /// The pull date for the re-scan mode.
    pull_date_rescan_mode: ?EcrPullDateRescanMode = null,

    /// The rescan duration configured for image push date.
    rescan_duration: ?EcrRescanDuration = null,

    /// The status of changes to the ECR automated re-scan duration.
    status: ?EcrRescanDurationStatus = null,

    /// A timestamp representing when the last time the ECR scan duration setting
    /// was
    /// changed.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .pull_date_rescan_duration = "pullDateRescanDuration",
        .pull_date_rescan_mode = "pullDateRescanMode",
        .rescan_duration = "rescanDuration",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
