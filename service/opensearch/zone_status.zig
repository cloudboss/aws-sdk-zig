pub const ZoneStatus = enum {
    active,
    stand_by,
    not_available,

    pub const json_field_names = .{
        .active = "Active",
        .stand_by = "StandBy",
        .not_available = "NotAvailable",
    };
};
