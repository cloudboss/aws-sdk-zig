const AppliedStatus = @import("applied_status.zig").AppliedStatus;
const PracticeRunOutcome = @import("practice_run_outcome.zig").PracticeRunOutcome;
const ShiftType = @import("shift_type.zig").ShiftType;

/// A complex structure that lists the zonal shifts for a managed resource and
/// their statuses for the resource.
pub const ZonalShiftInResource = struct {
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
    applied_status: AppliedStatus,

    /// The Availability Zone (for example, `use1-az1`) that traffic is moved away
    /// from for a resource when you start a zonal shift. Until the zonal shift
    /// expires or you cancel it, traffic for the resource is instead moved to other
    /// Availability Zones in the Amazon Web Services Region.
    away_from: []const u8,

    /// A comment that you enter for a customer-initiated zonal shift. Only the
    /// latest comment is retained; no comment history is maintained. That is, a new
    /// comment overwrites any existing comment string.
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

    /// The outcome, or end state, returned for a practice run. The following values
    /// can be returned:
    ///
    /// * **PENDING:** Outcome value when a practice run is in progress.
    /// * **SUCCEEDED:** Outcome value when the outcome alarm specified for the
    ///   practice run configuration does not go into an `ALARM` state during the
    ///   practice run, and the practice run was not interrupted before it completed
    ///   the expected 30 minute zonal shift.
    /// * **INTERRUPTED:** Outcome value when the practice run was stopped before
    ///   the expected 30 minute zonal shift duration, or there was another problem
    ///   with the practice run that created an inconclusive outcome.
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
    practice_run_outcome: ?PracticeRunOutcome = null,

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
    ///   Balancer](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.app-load-balancers.html)
    /// * [Network Load
    ///   Balancer](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.network-load-balancers.html)
    resource_identifier: []const u8,

    /// Defines the zonal shift type.
    shift_type: ?ShiftType = null,

    /// The time (UTC) when the zonal shift starts.
    start_time: i64,

    /// The identifier of a zonal shift.
    zonal_shift_id: []const u8,

    pub const json_field_names = .{
        .applied_status = "appliedStatus",
        .away_from = "awayFrom",
        .comment = "comment",
        .expiry_time = "expiryTime",
        .practice_run_outcome = "practiceRunOutcome",
        .resource_identifier = "resourceIdentifier",
        .shift_type = "shiftType",
        .start_time = "startTime",
        .zonal_shift_id = "zonalShiftId",
    };
};
