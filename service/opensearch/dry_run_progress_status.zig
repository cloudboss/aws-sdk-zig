const ValidationFailure = @import("validation_failure.zig").ValidationFailure;

/// Information about the progress of a pre-upgrade dry run analysis.
pub const DryRunProgressStatus = struct {
    /// The timestamp when the dry run was initiated.
    creation_date: []const u8,

    /// The unique identifier of the dry run.
    dry_run_id: []const u8,

    /// The current status of the dry run.
    dry_run_status: []const u8,

    /// The timestamp when the dry run was last updated.
    update_date: []const u8,

    /// Any validation failures that occurred as a result of the dry run.
    validation_failures: ?[]const ValidationFailure = null,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .dry_run_id = "DryRunId",
        .dry_run_status = "DryRunStatus",
        .update_date = "UpdateDate",
        .validation_failures = "ValidationFailures",
    };
};
