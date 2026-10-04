const ApplyCancellationCharges = @import("apply_cancellation_charges.zig").ApplyCancellationCharges;

/// Describes the cancellation terms for cancelling a future-dated Capacity
/// Reservation
/// during its commitment duration.
pub const CancellationTerms = struct {
    /// The type of cancellation charge. Possible values include
    /// `commitment-wind-down`.
    cancellation_type: ?ApplyCancellationCharges = null,

    /// The number of hours for which cancellation charges will apply.
    charge_commitment_duration_hours: ?i64 = null,

    /// The date and time at which cancellation charges will stop.
    charge_end_date: ?i64 = null,

    /// The number of instances under commitment after cancellation.
    committed_instance_count: ?i32 = null,

    /// The state that the Capacity Reservation will transition to after
    /// cancellation.
    reservation_state: ?[]const u8 = null,
};
