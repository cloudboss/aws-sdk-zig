pub const PrefetchScheduleType = enum {
    single,
    recurring,

    pub const json_field_names = .{
        .single = "SINGLE",
        .recurring = "RECURRING",
    };
};
