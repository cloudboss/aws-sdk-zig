const BatchReportModeType = @import("batch_report_mode_type.zig").BatchReportModeType;
const BatchRestrictions = @import("batch_restrictions.zig").BatchRestrictions;

/// Contains configuration information about a batch build project.
pub const ProjectBuildBatchConfig = struct {
    /// Specifies how build status reports are sent to the source provider for the
    /// batch build. This property is only used
    /// when the source provider for your project is Bitbucket, GitHub, or GitHub
    /// Enterprise,
    /// and your project is configured to report build statuses to the source
    /// provider.
    ///
    /// **REPORT_AGGREGATED_BATCH**
    ///
    /// (Default) Aggregate all of the build statuses into a single status report.
    ///
    /// **REPORT_INDIVIDUAL_BUILDS**
    ///
    /// Send a separate status report for each individual build.
    batch_report_mode: ?BatchReportModeType = null,

    /// Specifies if the build artifacts for the batch build should be combined into
    /// a single
    /// artifact location.
    combine_artifacts: ?bool = null,

    /// A `BatchRestrictions` object that specifies the restrictions for the batch
    /// build.
    restrictions: ?BatchRestrictions = null,

    /// Specifies the service role ARN for the batch build project.
    service_role: ?[]const u8 = null,

    /// Specifies the maximum amount of time, in minutes, that the batch build must
    /// be completed in.
    timeout_in_mins: ?i32 = null,

    pub const json_field_names = .{
        .batch_report_mode = "batchReportMode",
        .combine_artifacts = "combineArtifacts",
        .restrictions = "restrictions",
        .service_role = "serviceRole",
        .timeout_in_mins = "timeoutInMins",
    };
};
