pub const MaintenanceType = enum {
    preferred_day_time,
    default,

    pub const json_field_names = .{
        .preferred_day_time = "PREFERRED_DAY_TIME",
        .default = "DEFAULT",
    };
};
