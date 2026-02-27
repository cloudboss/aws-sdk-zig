pub const ReservationState = enum {
    active,
    expired,
    processing,
    canceled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .expired = "EXPIRED",
        .processing = "PROCESSING",
        .canceled = "CANCELED",
    };
};
