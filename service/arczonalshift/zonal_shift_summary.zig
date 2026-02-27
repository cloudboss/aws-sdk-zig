const PracticeRunOutcome = @import("practice_run_outcome.zig").PracticeRunOutcome;
const ShiftType = @import("shift_type.zig").ShiftType;
const ZonalShiftStatus = @import("zonal_shift_status.zig").ZonalShiftStatus;

/// Lists information about zonal shifts in Amazon Application Recovery
/// Controller, including zonal shifts that you start yourself and zonal shifts
/// that ARC starts on your behalf for practice runs with zonal autoshift.
///
/// Zonal shifts are temporary, including customer-initiated zonal shifts and
/// the zonal autoshift practice run zonal shifts that ARC starts weekly, on
/// your behalf. A zonal shift that a customer starts can be active for up to
/// three days (72 hours). A practice run zonal shift has a 30 minute duration.
pub const ZonalShiftSummary = struct {
    /// The Availability Zone (for example, `use1-az1`) that traffic is moved away
    /// from for a resource when you start a zonal shift. Until the zonal shift
    /// expires or you cancel it, traffic for the resource is instead moved to other
    /// Availability Zones in the Amazon Web Services Region.
    away_from: []const u8,

    /// A comment that you enter about the zonal shift. Only the latest comment is
    /// retained; no comment history is maintained. That is, a new comment
    /// overwrites any existing comment string.
    comment: []const u8,

    /// The expiry time (expiration time) for a customer-initiated zonal shift. A
    /// zonal shift is temporary and must be set to expire when you start the zonal
    /// shift. You can initially set a zonal shift to expire in a maximum of three
    /// days (72 hours). However, you can update a zonal shift to set a new
    /// expiration at any time.
    ///
    /// When you start a zonal shift, you specify how long you want it to be active,
    /// which ARC converts to an expiry time (expiration time). You can cancel a
    /// zonal shift when you're ready to restore traffic to the Availability Zone,
    /// or just wait for it to expire. Or you can update the zonal shift to specify
    /// another length of time to expire in.
    expiry_time: i64,

    /// The outcome, or end state, of a practice run. The following values can be
    /// returned:
    ///
    /// * **PENDING:** Outcome value when the practice run is in progress.
    /// * **SUCCEEDED:** Outcome value when the outcome alarm specified for the
    ///   practice run configuration does not go into an `ALARM` state during the
    ///   practice run, and the practice run was not interrupted before it
    ///   completed.
    /// * **INTERRUPTED:** Outcome value when the practice run did not run for the
    ///   expected 30 minutes or there was another problem with the practice run
    ///   that created an inconclusive outcome.
    /// * **FAILED:** Outcome value when the outcome alarm specified for the
    ///   practice run configuration goes into an `ALARM` state during the practice
    ///   run, and the practice run was not interrupted before it completed.
    /// * **CAPACITY_CHECK_FAILED:** The check for balanced capacity across
    ///   Availability Zones for your load balancing and Auto Scaling group
    ///   resources failed.
    ///
    /// For more information about practice run outcomes, see [ Considerations when
    /// you configure zonal
    /// autoshift](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-autoshift.configure.html) in the Amazon Application Recovery Controller Developer Guide.
    practice_run_outcome: ?PracticeRunOutcome,

    /// The identifier for the resource to include in a zonal shift. The identifier
    /// is the Amazon Resource Name (ARN) for the resource.
    ///
    /// Amazon Application Recovery Controller currently supports enabling the
    /// following resources for zonal shift and zonal autoshift:
    ///
    /// * [Amazon EC2 Auto Scaling
    ///   groups](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.ec2-auto-scaling-groups.html)
    /// * [Amazon Elastic Kubernetes
    ///   Service](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.eks.html)
    /// * [Application Load
    ///   Balancers](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.app-load-balancers.html)
    /// * [Network Load
    ///   Balancers](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.network-load-balancers.html)
    resource_identifier: []const u8,

    /// Defines the zonal shift type.
    shift_type: ?ShiftType,

    /// The time (UTC) when the zonal shift starts.
    start_time: i64,

    /// A status for a zonal shift.
    ///
    /// The `Status` for a zonal shift can have one of the following values:
    ///
    /// * **ACTIVE:** The zonal shift has been started and is active.
    /// * **EXPIRED:** The zonal shift has expired (the expiry time was exceeded).
    /// * **CANCELED:** The zonal shift was canceled.
    status: ZonalShiftStatus,

    /// The identifier of a zonal shift.
    zonal_shift_id: []const u8,

    pub const json_field_names = .{
        .away_from = "awayFrom",
        .comment = "comment",
        .expiry_time = "expiryTime",
        .practice_run_outcome = "practiceRunOutcome",
        .resource_identifier = "resourceIdentifier",
        .shift_type = "shiftType",
        .start_time = "startTime",
        .status = "status",
        .zonal_shift_id = "zonalShiftId",
    };
};
