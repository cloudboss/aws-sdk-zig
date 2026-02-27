pub const ListPrefetchScheduleType = enum {
    single,
    recurring,
    all,

    pub const json_field_names = .{
        .single = "SINGLE",
        .recurring = "RECURRING",
        .all = "ALL",
    };
};
