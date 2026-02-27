pub const ZonalShiftStatus = enum {
    active,
    expired,
    canceled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .expired = "EXPIRED",
        .canceled = "CANCELED",
    };
};
