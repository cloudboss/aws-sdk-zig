/// Describes the changes that a Capacity Reservation modification quote will
/// apply to a
/// Capacity Reservation.
pub const ModificationReservationUpdate = struct {
    /// The commitment duration, in seconds, that the Capacity Reservation will have
    /// after the
    /// modification.
    new_commitment_duration: ?i32 = null,

    /// The date and time at which the commitment duration will expire after the
    /// modification,
    /// in the ISO8601 format in the UTC time zone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    new_commitment_end_date: ?i64 = null,

    /// The start date that the Capacity Reservation will have after the
    /// modification, in the
    /// ISO8601 format in the UTC time zone (`YYYY-MM-DDThh:mm:ss.sssZ`).
    new_start_date: ?i64 = null,
};
