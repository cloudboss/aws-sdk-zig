const AutoshiftAppliedStatus = @import("autoshift_applied_status.zig").AutoshiftAppliedStatus;

/// A complex structure that lists an autoshift that is currently active for a
/// managed resource and information about the autoshift.
///
/// For more information, see [How zonal autoshift and practice runs
/// work](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-autoshift.how-it-works.html) in the Amazon Application Recovery Controller Developer Guide.
pub const AutoshiftInResource = struct {
    /// The `appliedStatus` field specifies which application traffic shift is in
    /// effect for a resource when there is more than one active traffic shift.
    /// There can be more than one application traffic shift in progress at the same
    /// time - that is, practice run zonal shifts, customer-initiated zonal shifts,
    /// or an autoshift. The `appliedStatus` field for a shift that is in progress
    /// for a resource can have one of two values: `APPLIED` or `NOT_APPLIED`. The
    /// zonal shift or autoshift that is currently in effect for the resource has an
    /// `appliedStatus` set to `APPLIED`.
    ///
    /// The overall principle for precedence is that zonal shifts that you start as
    /// a customer take precedence autoshifts, which take precedence over practice
    /// runs. That is, customer-initiated zonal shifts > autoshifts > practice run
    /// zonal shifts.
    ///
    /// For more information, see [How zonal autoshift and practice runs
    /// work](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-autoshift.how-it-works.html) in the Amazon Application Recovery Controller Developer Guide.
    applied_status: AutoshiftAppliedStatus,

    /// The Availability Zone (for example, `use1-az1`) that traffic is shifted away
    /// from for a resource, when Amazon Web Services starts an autoshift. Until the
    /// autoshift ends, traffic for the resource is instead directed to other
    /// Availability Zones in the Amazon Web Services Region. An autoshift can end
    /// for a resource, for example, when Amazon Web Services ends the autoshift for
    /// the Availability Zone or when you disable zonal autoshift for the resource.
    away_from: []const u8,

    /// The time (UTC) when the autoshift started.
    start_time: i64,

    pub const json_field_names = .{
        .applied_status = "appliedStatus",
        .away_from = "awayFrom",
        .start_time = "startTime",
    };
};
