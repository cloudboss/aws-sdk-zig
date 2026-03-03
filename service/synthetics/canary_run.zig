const BrowserType = @import("browser_type.zig").BrowserType;
const CanaryDryRunConfigOutput = @import("canary_dry_run_config_output.zig").CanaryDryRunConfigOutput;
const CanaryRunStatus = @import("canary_run_status.zig").CanaryRunStatus;
const CanaryRunTimeline = @import("canary_run_timeline.zig").CanaryRunTimeline;

/// This structure contains the details about one run of one canary.
pub const CanaryRun = struct {
    /// The location where the canary stored artifacts from the run. Artifacts
    /// include
    /// the log file, screenshots, and HAR files.
    artifact_s3_location: ?[]const u8 = null,

    /// The browser type associated with this canary run.
    browser_type: ?BrowserType = null,

    /// Returns the dry run configurations for a canary.
    dry_run_config: ?CanaryDryRunConfigOutput = null,

    /// A unique ID that identifies this canary run.
    id: ?[]const u8 = null,

    /// The name of the canary.
    name: ?[]const u8 = null,

    /// The count in number of the retry attempt.
    retry_attempt: ?i32 = null,

    /// The ID of the scheduled canary run.
    scheduled_run_id: ?[]const u8 = null,

    /// The status of this run.
    status: ?CanaryRunStatus = null,

    /// A structure that contains the start and end times of this run.
    timeline: ?CanaryRunTimeline = null,

    pub const json_field_names = .{
        .artifact_s3_location = "ArtifactS3Location",
        .browser_type = "BrowserType",
        .dry_run_config = "DryRunConfig",
        .id = "Id",
        .name = "Name",
        .retry_attempt = "RetryAttempt",
        .scheduled_run_id = "ScheduledRunId",
        .status = "Status",
        .timeline = "Timeline",
    };
};
