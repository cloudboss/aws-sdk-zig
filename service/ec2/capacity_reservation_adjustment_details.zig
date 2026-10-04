/// Describes the configuration that a Capacity Reservation will have after a
/// pending
/// adjustment is applied.
pub const CapacityReservationAdjustmentDetails = struct {
    /// The commitment duration, in seconds, that the Capacity Reservation will have
    /// after the
    /// adjustment.
    commitment_duration: ?i64 = null,

    /// The date and time at which the commitment duration will expire after the
    /// adjustment.
    commitment_end_date: ?i64 = null,

    /// The end date that the Capacity Reservation will have after the adjustment.
    end_date: ?i64 = null,

    /// Indicates the way in which the Capacity Reservation will end after the
    /// adjustment.
    /// Possible values are:
    ///
    /// * `unlimited` - The Capacity Reservation remains active until you
    /// explicitly cancel it.
    ///
    /// * `limited` - The Capacity Reservation expires automatically at the
    /// date and time given by `endDate`.
    end_date_type: ?[]const u8 = null,

    /// The start date that the Capacity Reservation will have after the adjustment.
    start_date: ?i64 = null,
};
