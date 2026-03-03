/// Information about the Capacity Reservation usage.
pub const InstanceUsage = struct {
    /// The ID of the Amazon Web Services account that is making use of the Capacity
    /// Reservation.
    account_id: ?[]const u8 = null,

    /// The number of instances the Amazon Web Services account currently has in the
    /// Capacity
    /// Reservation.
    used_instance_count: ?i32 = null,
};
