pub const AlarmCondition = enum {
    red,
    green,

    pub const json_field_names = .{
        .red = "RED",
        .green = "GREEN",
    };
};
