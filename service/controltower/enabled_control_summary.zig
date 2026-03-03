const DriftStatusSummary = @import("drift_status_summary.zig").DriftStatusSummary;
const EnablementStatusSummary = @import("enablement_status_summary.zig").EnablementStatusSummary;

/// Returns a summary of information about an enabled control.
pub const EnabledControlSummary = struct {
    /// The ARN of the enabled control.
    arn: ?[]const u8 = null,

    /// The `controlIdentifier` of the enabled control.
    control_identifier: ?[]const u8 = null,

    /// The drift status of the enabled control.
    drift_status_summary: ?DriftStatusSummary = null,

    /// The ARN of the parent enabled control from which this control inherits its
    /// configuration, if applicable.
    parent_identifier: ?[]const u8 = null,

    /// A short description of the status of the enabled control.
    status_summary: ?EnablementStatusSummary = null,

    /// The ARN of the organizational unit.
    target_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .control_identifier = "controlIdentifier",
        .drift_status_summary = "driftStatusSummary",
        .parent_identifier = "parentIdentifier",
        .status_summary = "statusSummary",
        .target_identifier = "targetIdentifier",
    };
};
