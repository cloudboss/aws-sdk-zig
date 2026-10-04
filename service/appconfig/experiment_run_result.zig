/// The result of an experiment run, including the executive summary and launch
/// decision rationale.
pub const ExperimentRunResult = struct {
    /// A summary of the experiment outcome and key findings.
    executive_summary: ?[]const u8 = null,

    /// Evidence against launching the treatment.
    reasons_not_to_launch: ?[]const u8 = null,

    /// Evidence in favor of launching the winning treatment.
    reasons_to_launch: ?[]const u8 = null,

    pub const json_field_names = .{
        .executive_summary = "ExecutiveSummary",
        .reasons_not_to_launch = "ReasonsNotToLaunch",
        .reasons_to_launch = "ReasonsToLaunch",
    };
};
