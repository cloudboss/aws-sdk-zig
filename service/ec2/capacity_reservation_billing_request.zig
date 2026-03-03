const CapacityReservationInfo = @import("capacity_reservation_info.zig").CapacityReservationInfo;
const CapacityReservationBillingRequestStatus = @import("capacity_reservation_billing_request_status.zig").CapacityReservationBillingRequestStatus;

/// Information about a request to assign billing of the unused capacity of a
/// Capacity
/// Reservation.
pub const CapacityReservationBillingRequest = struct {
    /// The ID of the Capacity Reservation.
    capacity_reservation_id: ?[]const u8 = null,

    /// Information about the Capacity Reservation.
    capacity_reservation_info: ?CapacityReservationInfo = null,

    /// The date and time, in UTC time format, at which the request was initiated.
    last_update_time: ?i64 = null,

    /// The ID of the Amazon Web Services account that initiated the request.
    requested_by: ?[]const u8 = null,

    /// The status of the request. For more information, see [ View billing
    /// assignment
    /// requests for a shared Amazon EC2 Capacity
    /// Reservation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/view-billing-transfers.html).
    status: ?CapacityReservationBillingRequestStatus = null,

    /// Information about the status.
    status_message: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account to which the request was sent.
    unused_reservation_billing_owner_id: ?[]const u8 = null,
};
