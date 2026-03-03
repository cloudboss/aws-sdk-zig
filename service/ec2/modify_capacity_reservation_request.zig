const EndDateType = @import("end_date_type.zig").EndDateType;
const InstanceMatchCriteria = @import("instance_match_criteria.zig").InstanceMatchCriteria;

pub const ModifyCapacityReservationRequest = struct {
    /// Reserved. Capacity Reservations you have created are accepted by default.
    accept: ?bool = null,

    /// Reserved for future use.
    additional_info: ?[]const u8 = null,

    /// The ID of the Capacity Reservation.
    capacity_reservation_id: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The date and time at which the Capacity Reservation expires. When a Capacity
    /// Reservation expires, the reserved capacity is released and you can no longer
    /// launch
    /// instances into it. The Capacity Reservation's state changes to `expired`
    /// when
    /// it reaches its end date and time.
    ///
    /// The Capacity Reservation is cancelled within an hour from the specified
    /// time. For
    /// example, if you specify 5/31/2019, 13:30:55, the Capacity Reservation is
    /// guaranteed to
    /// end between 13:30:55 and 14:30:55 on 5/31/2019.
    ///
    /// You must provide an `EndDate` value if `EndDateType` is
    /// `limited`. Omit `EndDate` if `EndDateType` is
    /// `unlimited`.
    end_date: ?i64 = null,

    /// Indicates the way in which the Capacity Reservation ends. A Capacity
    /// Reservation can
    /// have one of the following end types:
    ///
    /// * `unlimited` - The Capacity Reservation remains active until you
    /// explicitly cancel it. Do not provide an `EndDate` value if
    /// `EndDateType` is `unlimited`.
    ///
    /// * `limited` - The Capacity Reservation expires automatically at a
    /// specified date and time. You must provide an `EndDate` value if
    /// `EndDateType` is `limited`.
    end_date_type: ?EndDateType = null,

    /// The number of instances for which to reserve capacity. The number of
    /// instances can't
    /// be increased or decreased by more than `1000` in a single request.
    instance_count: ?i32 = null,

    /// The matching criteria (instance eligibility) that you want to use in the
    /// modified
    /// Capacity Reservation. If you change the instance eligibility of an existing
    /// Capacity
    /// Reservation from `targeted` to `open`, any running instances that
    /// match the attributes of the Capacity Reservation, have the
    /// `CapacityReservationPreference` set to `open`, and are not yet
    /// running in the Capacity Reservation, will automatically use the modified
    /// Capacity
    /// Reservation.
    ///
    /// To modify the instance eligibility, the Capacity Reservation must be
    /// completely idle
    /// (zero usage).
    instance_match_criteria: ?InstanceMatchCriteria = null,
};
