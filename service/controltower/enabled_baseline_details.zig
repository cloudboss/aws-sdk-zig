const EnabledBaselineDriftStatusSummary = @import("enabled_baseline_drift_status_summary.zig").EnabledBaselineDriftStatusSummary;
const EnabledBaselineParameterSummary = @import("enabled_baseline_parameter_summary.zig").EnabledBaselineParameterSummary;
const EnablementStatusSummary = @import("enablement_status_summary.zig").EnablementStatusSummary;

/// Details of the `EnabledBaseline` resource.
pub const EnabledBaselineDetails = struct {
    /// The ARN of the `EnabledBaseline` resource.
    arn: []const u8,

    /// The specific `Baseline` enabled as part of the `EnabledBaseline` resource.
    baseline_identifier: []const u8,

    /// The enabled version of the `Baseline`.
    baseline_version: ?[]const u8 = null,

    /// The drift status of the enabled baseline.
    drift_status_summary: ?EnabledBaselineDriftStatusSummary = null,

    /// Shows the parameters that are applied when enabling this `Baseline`.
    parameters: ?[]const EnabledBaselineParameterSummary = null,

    /// An ARN that represents the parent `EnabledBaseline` at the Organizational
    /// Unit (OU) level, from which the child `EnabledBaseline` inherits its
    /// configuration. The value is returned by `GetEnabledBaseline`.
    parent_identifier: ?[]const u8 = null,

    status_summary: EnablementStatusSummary,

    /// The target on which to enable the `Baseline`.
    target_identifier: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .baseline_identifier = "baselineIdentifier",
        .baseline_version = "baselineVersion",
        .drift_status_summary = "driftStatusSummary",
        .parameters = "parameters",
        .parent_identifier = "parentIdentifier",
        .status_summary = "statusSummary",
        .target_identifier = "targetIdentifier",
    };
};
