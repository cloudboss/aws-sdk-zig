const EnabledBaselineDriftStatusSummary = @import("enabled_baseline_drift_status_summary.zig").EnabledBaselineDriftStatusSummary;
const EnablementStatusSummary = @import("enablement_status_summary.zig").EnablementStatusSummary;

/// Returns a summary of information about an `EnabledBaseline` object.
pub const EnabledBaselineSummary = struct {
    /// The ARN of the `EnabledBaseline` resource
    arn: []const u8,

    /// The specific baseline that is enabled as part of the `EnabledBaseline`
    /// resource.
    baseline_identifier: []const u8,

    /// The enabled version of the baseline.
    baseline_version: ?[]const u8,

    /// The drift status of the enabled baseline.
    drift_status_summary: ?EnabledBaselineDriftStatusSummary,

    /// An ARN that represents an object returned by `ListEnabledBaseline`, to
    /// describe an enabled baseline.
    parent_identifier: ?[]const u8,

    status_summary: EnablementStatusSummary,

    /// The target upon which the baseline is enabled.
    target_identifier: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .baseline_identifier = "baselineIdentifier",
        .baseline_version = "baselineVersion",
        .drift_status_summary = "driftStatusSummary",
        .parent_identifier = "parentIdentifier",
        .status_summary = "statusSummary",
        .target_identifier = "targetIdentifier",
    };
};
