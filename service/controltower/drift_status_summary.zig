const DriftStatus = @import("drift_status.zig").DriftStatus;
const EnabledControlDriftTypes = @import("enabled_control_drift_types.zig").EnabledControlDriftTypes;

/// The drift summary of the enabled control.
///
/// Amazon Web Services Control Tower expects the enabled control configuration
/// to include all supported and governed Regions. If the enabled control
/// differs from the expected configuration, it is defined to be in a state of
/// drift. You can repair this drift by resetting the enabled control.
pub const DriftStatusSummary = struct {
    /// The drift status of the enabled control.
    ///
    /// Valid values:
    ///
    /// * `DRIFTED`: The `enabledControl` deployed in this configuration doesn’t
    ///   match the configuration that Amazon Web Services Control Tower expected.
    /// * `IN_SYNC`: The `enabledControl` deployed in this configuration matches the
    ///   configuration that Amazon Web Services Control Tower expected.
    /// * `NOT_CHECKING`: Amazon Web Services Control Tower does not check drift for
    ///   this enabled control. Drift is not supported for the control type.
    /// * `UNKNOWN`: Amazon Web Services Control Tower is not able to check the
    ///   drift status for the enabled control.
    drift_status: ?DriftStatus,

    /// An object that categorizes the different types of drift detected for the
    /// enabled control.
    types: ?EnabledControlDriftTypes,

    pub const json_field_names = .{
        .drift_status = "driftStatus",
        .types = "types",
    };
};
