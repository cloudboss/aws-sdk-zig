pub const CapacityReservationStatus = enum {
    pending,
    active,
    cancelling,
    cancelled,
    failed,
    update_pending,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .update_pending = "UPDATE_PENDING",
    };
};
