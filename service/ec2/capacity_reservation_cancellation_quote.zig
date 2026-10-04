const CancellationTerms = @import("cancellation_terms.zig").CancellationTerms;
const CapacityReservationConfiguration = @import("capacity_reservation_configuration.zig").CapacityReservationConfiguration;
const CapacityReservationCancellationQuoteState = @import("capacity_reservation_cancellation_quote_state.zig").CapacityReservationCancellationQuoteState;
const Tag = @import("tag.zig").Tag;

/// Describes a Capacity Reservation cancellation quote, which provides the
/// cancellation
/// terms for cancelling a future-dated Capacity Reservation during its
/// commitment
/// duration.
pub const CapacityReservationCancellationQuote = struct {
    /// The cancellation terms associated with the quote, including the fee type and
    /// charge details.
    cancellation_terms: ?[]const CancellationTerms = null,

    /// The ID of the cancellation quote.
    capacity_reservation_cancellation_quote_id: ?[]const u8 = null,

    /// The ID of the Capacity Reservation associated with the cancellation quote.
    capacity_reservation_id: ?[]const u8 = null,

    /// The date and time at which the cancellation quote was created.
    create_time: ?i64 = null,

    /// The current configuration of the Capacity Reservation.
    current_configuration: ?CapacityReservationConfiguration = null,

    /// The date and time at which the cancellation quote expires.
    expiration_time: ?i64 = null,

    /// The state of the cancellation quote. Possible values include
    /// `pending`, `active`, and `expired`.
    quote_state: ?CapacityReservationCancellationQuoteState = null,

    /// The tags assigned to the cancellation quote.
    tags: ?[]const Tag = null,
};
