pub const CapacityReservationPreferenceEnum = enum {
    capacity_reservations_only,
    open,
    none,

    pub const json_field_names = .{
        .capacity_reservations_only = "CAPACITY_RESERVATIONS_ONLY",
        .open = "OPEN",
        .none = "NONE",
    };
};
