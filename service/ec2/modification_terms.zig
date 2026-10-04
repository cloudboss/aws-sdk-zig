const ModificationReservationUpdate = @import("modification_reservation_update.zig").ModificationReservationUpdate;

/// Describes the terms of a Capacity Reservation modification quote.
pub const ModificationTerms = struct {
    /// The changes that will be applied to the Capacity Reservation if you accept
    /// the
    /// modification terms.
    reservation_update: ?ModificationReservationUpdate = null,
};
