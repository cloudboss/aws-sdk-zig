const EcrPullDateRescanDuration = @import("ecr_pull_date_rescan_duration.zig").EcrPullDateRescanDuration;
const EcrPullDateRescanMode = @import("ecr_pull_date_rescan_mode.zig").EcrPullDateRescanMode;
const EcrRescanDuration = @import("ecr_rescan_duration.zig").EcrRescanDuration;

/// Details about the ECR automated re-scan duration setting for your
/// environment.
pub const EcrConfiguration = struct {
    /// The rescan duration configured for image pull date.
    pull_date_rescan_duration: ?EcrPullDateRescanDuration,

    /// The pull date for the re-scan mode.
    pull_date_rescan_mode: ?EcrPullDateRescanMode,

    /// The rescan duration configured for image push date.
    rescan_duration: EcrRescanDuration,

    pub const json_field_names = .{
        .pull_date_rescan_duration = "pullDateRescanDuration",
        .pull_date_rescan_mode = "pullDateRescanMode",
        .rescan_duration = "rescanDuration",
    };
};
