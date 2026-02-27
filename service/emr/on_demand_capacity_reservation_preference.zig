pub const OnDemandCapacityReservationPreference = enum {
    open,
    none,

    pub const json_field_names = .{
        .open = "OPEN",
        .none = "NONE",
    };
};
