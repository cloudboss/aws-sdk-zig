pub const LogType = enum {
    none,
    tail,

    pub const json_field_names = .{
        .none = "None",
        .tail = "Tail",
    };
};
