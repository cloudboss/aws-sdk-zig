pub const StandardMessages = enum {
    auto,
    all,
    mentions,
    none,

    pub const json_field_names = .{
        .auto = "AUTO",
        .all = "ALL",
        .mentions = "MENTIONS",
        .none = "NONE",
    };
};
