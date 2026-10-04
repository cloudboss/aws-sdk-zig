const ValidationFailure = @import("validation_failure.zig").ValidationFailure;

/// Information about the progress of a pre-upgrade dry run analysis.
pub const DryRunProgressStatus = struct {
    /// The list of advisory warning codes that were accepted for the configuration
    /// change.
    accepted_warnings: ?[]const []const u8 = null,

    /// The timestamp when the dry run was initiated.
    creation_date: []const u8,

    /// The unique identifier of the dry run.
    dry_run_id: []const u8,

    /// The current status of the dry run.
    dry_run_status: []const u8,

    /// The timestamp when the dry run was last updated.
    update_date: []const u8,

    /// The validation failures that occurred as a result of the dry run.
    validation_failures: ?[]const ValidationFailure = null,

    pub const json_field_names = .{
        .accepted_warnings = "AcceptedWarnings",
        .creation_date = "CreationDate",
        .dry_run_id = "DryRunId",
        .dry_run_status = "DryRunStatus",
        .update_date = "UpdateDate",
        .validation_failures = "ValidationFailures",
    };
};
