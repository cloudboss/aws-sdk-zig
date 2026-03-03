/// Information about your commitment for a future-dated Capacity Reservation.
pub const CapacityReservationCommitmentInfo = struct {
    /// The date and time at which the commitment duration expires, in the ISO8601
    /// format in
    /// the UTC time zone (`YYYY-MM-DDThh:mm:ss.sssZ`). You can't decrease the
    /// instance count or cancel the Capacity Reservation before this date and time.
    commitment_end_date: ?i64 = null,

    /// The instance capacity that you committed to when you requested the
    /// future-dated
    /// Capacity Reservation.
    committed_instance_count: ?i32 = null,
};
