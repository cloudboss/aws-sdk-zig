const DriftStatusSummary = @import("drift_status_summary.zig").DriftStatusSummary;
const EnabledControlParameterSummary = @import("enabled_control_parameter_summary.zig").EnabledControlParameterSummary;
const EnablementStatusSummary = @import("enablement_status_summary.zig").EnablementStatusSummary;
const Region = @import("region.zig").Region;

/// Information about the enabled control.
pub const EnabledControlDetails = struct {
    /// The ARN of the enabled control.
    arn: ?[]const u8,

    /// The control identifier of the enabled control. For information on how to
    /// find the `controlIdentifier`, see [the overview
    /// page](https://docs.aws.amazon.com/controltower/latest/APIReference/Welcome.html).
    control_identifier: ?[]const u8,

    /// The drift status of the enabled control.
    drift_status_summary: ?DriftStatusSummary,

    /// Array of `EnabledControlParameter` objects.
    parameters: ?[]const EnabledControlParameterSummary,

    /// The ARN of the parent enabled control from which this control inherits its
    /// configuration, if applicable.
    parent_identifier: ?[]const u8,

    /// The deployment summary of the enabled control.
    status_summary: ?EnablementStatusSummary,

    /// The ARN of the organizational unit. For information on how to find the
    /// `targetIdentifier`, see [the overview
    /// page](https://docs.aws.amazon.com/controltower/latest/APIReference/Welcome.html).
    target_identifier: ?[]const u8,

    /// Target Amazon Web Services Regions for the enabled control.
    target_regions: ?[]const Region,

    pub const json_field_names = .{
        .arn = "arn",
        .control_identifier = "controlIdentifier",
        .drift_status_summary = "driftStatusSummary",
        .parameters = "parameters",
        .parent_identifier = "parentIdentifier",
        .status_summary = "statusSummary",
        .target_identifier = "targetIdentifier",
        .target_regions = "targetRegions",
    };
};
