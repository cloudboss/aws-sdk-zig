const InterruptionType = @import("interruption_type.zig").InterruptionType;

/// Contains information about how and when instances in an interruptible
/// reservation can be terminated when capacity is reclaimed.
pub const InterruptionInfo = struct {
    /// The interruption type that determines how instances are terminated when
    /// capacity is reclaimed.
    interruption_type: ?InterruptionType,

    /// The ID of the source Capacity Reservation from which the interruptible
    /// reservation was created.
    source_capacity_reservation_id: ?[]const u8,
};
