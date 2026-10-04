const ModificationQuoteCurrentConfiguration = @import("modification_quote_current_configuration.zig").ModificationQuoteCurrentConfiguration;
const ModificationTerms = @import("modification_terms.zig").ModificationTerms;
const CapacityReservationModificationQuoteState = @import("capacity_reservation_modification_quote_state.zig").CapacityReservationModificationQuoteState;
const Tag = @import("tag.zig").Tag;

/// Describes a Capacity Reservation modification quote, which provides the
/// terms for
/// changing the start date or the commitment of a future-dated Capacity
/// Reservation.
pub const CapacityReservationModificationQuote = struct {
    /// The ID of the Capacity Reservation associated with the modification quote.
    capacity_reservation_id: ?[]const u8 = null,

    /// The ID of the modification quote.
    capacity_reservation_modification_quote_id: ?[]const u8 = null,

    /// The date and time at which the modification quote was created.
    create_time: ?i64 = null,

    /// The configuration that the Capacity Reservation has at the time the quote
    /// was
    /// generated.
    current_configuration: ?ModificationQuoteCurrentConfiguration = null,

    /// The date and time at which the modification quote expires.
    expiration_time: ?i64 = null,

    /// The terms of the modification, including the configuration that the Capacity
    /// Reservation
    /// will have if you accept them by using `ModifyCapacityReservation`.
    modification_terms: ?ModificationTerms = null,

    /// The state of the modification quote itself. Possible values are:
    ///
    /// * `active` - The quote can still be used.
    ///
    /// * `expired` - The quote can no longer be used. A quote becomes
    /// `expired` at its `expirationTime`.
    quote_state: ?CapacityReservationModificationQuoteState = null,

    /// The tags assigned to the modification quote.
    tags: ?[]const Tag = null,
};
