const StatusType = @import("status_type.zig").StatusType;
const ResolvedArtifact = @import("resolved_artifact.zig").ResolvedArtifact;

/// Contains summary information about a batch build group.
pub const BuildSummary = struct {
    /// The batch build ARN.
    arn: ?[]const u8,

    /// The status of the build group.
    ///
    /// **FAILED**
    ///
    /// The build group failed.
    ///
    /// **FAULT**
    ///
    /// The build group faulted.
    ///
    /// **IN_PROGRESS**
    ///
    /// The build group is still in progress.
    ///
    /// **STOPPED**
    ///
    /// The build group stopped.
    ///
    /// **SUCCEEDED**
    ///
    /// The build group succeeded.
    ///
    /// **TIMED_OUT**
    ///
    /// The build group timed out.
    build_status: ?StatusType,

    /// A `ResolvedArtifact` object that represents the primary build artifacts for
    /// the
    /// build group.
    primary_artifact: ?ResolvedArtifact,

    /// When the build was started, expressed in Unix time format.
    requested_on: ?i64,

    /// An array of `ResolvedArtifact` objects that represents the secondary build
    /// artifacts for the build group.
    secondary_artifacts: ?[]const ResolvedArtifact,

    pub const json_field_names = .{
        .arn = "arn",
        .build_status = "buildStatus",
        .primary_artifact = "primaryArtifact",
        .requested_on = "requestedOn",
        .secondary_artifacts = "secondaryArtifacts",
    };
};
