const aws = @import("aws");

const JobStatus = @import("job_status.zig").JobStatus;

/// Describes an execution step, for an execution job, for an Amplify app.
pub const Step = struct {
    /// The URL to the build artifact for the execution step.
    artifacts_url: ?[]const u8 = null,

    /// The context for the current step. Includes a build image if the step is
    /// build.
    context: ?[]const u8 = null,

    /// The end date and time of the execution step.
    end_time: i64,

    /// The URL to the logs for the execution step.
    log_url: ?[]const u8 = null,

    /// The list of screenshot URLs for the execution step, if relevant.
    screenshots: ?[]const aws.map.StringMapEntry = null,

    /// The start date and time of the execution step.
    start_time: i64,

    /// The status of the execution step.
    status: JobStatus,

    /// The reason for the current step status.
    status_reason: ?[]const u8 = null,

    /// The name of the execution step.
    step_name: []const u8,

    /// The URL to the test artifact for the execution step.
    test_artifacts_url: ?[]const u8 = null,

    /// The URL to the test configuration for the execution step.
    test_config_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifacts_url = "artifactsUrl",
        .context = "context",
        .end_time = "endTime",
        .log_url = "logUrl",
        .screenshots = "screenshots",
        .start_time = "startTime",
        .status = "status",
        .status_reason = "statusReason",
        .step_name = "stepName",
        .test_artifacts_url = "testArtifactsUrl",
        .test_config_url = "testConfigUrl",
    };
};
