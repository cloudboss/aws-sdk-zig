pub const OnDemandCapacityReservationUsageStrategy = enum {
    use_capacity_reservations_first,

    pub const json_field_names = .{
        .use_capacity_reservations_first = "USE_CAPACITY_RESERVATIONS_FIRST",
    };
};
