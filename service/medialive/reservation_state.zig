/// Current reservation state
pub const ReservationState = enum {
    active,
    expired,
    canceled,
    deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .expired = "EXPIRED",
        .canceled = "CANCELED",
        .deleted = "DELETED",
    };
};
