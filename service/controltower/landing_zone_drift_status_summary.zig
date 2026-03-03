const LandingZoneDriftStatus = @import("landing_zone_drift_status.zig").LandingZoneDriftStatus;

/// The drift status summary of the landing zone.
///
/// If the landing zone differs from the expected configuration, it is defined
/// to be in a state of drift. You can repair this drift by resetting the
/// landing zone.
pub const LandingZoneDriftStatusSummary = struct {
    /// The drift status of the landing zone.
    ///
    /// Valid values:
    ///
    /// * `DRIFTED`: The landing zone deployed in this configuration does not match
    ///   the configuration that Amazon Web Services Control Tower expected.
    /// * `IN_SYNC`: The landing zone deployed in this configuration matches the
    ///   configuration that Amazon Web Services Control Tower expected.
    status: ?LandingZoneDriftStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
