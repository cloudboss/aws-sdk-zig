/// Returns the dry run configurations set for a canary.
pub const CanaryDryRunConfigOutput = struct {
    /// The DryRunId associated with an existing canary’s dry run. You can use this
    /// DryRunId to retrieve information about the dry run.
    dry_run_id: ?[]const u8,

    pub const json_field_names = .{
        .dry_run_id = "DryRunId",
    };
};
