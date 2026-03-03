/// Returns the dry run configurations set for a canary.
pub const DryRunConfigOutput = struct {
    /// The DryRunId associated with an existing canary’s dry run. You can use this
    /// DryRunId to retrieve information about the dry run.
    dry_run_id: ?[]const u8 = null,

    /// Returns the last execution status for a canary's dry run.
    last_dry_run_execution_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .dry_run_id = "DryRunId",
        .last_dry_run_execution_status = "LastDryRunExecutionStatus",
    };
};
