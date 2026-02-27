pub const ScheduleDisabledBy = enum {
    user,
    service,

    pub const json_field_names = .{
        .user = "USER",
        .service = "SERVICE",
    };
};
