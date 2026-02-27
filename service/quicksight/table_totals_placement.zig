pub const TableTotalsPlacement = enum {
    start,
    end,
    auto,

    pub const json_field_names = .{
        .start = "START",
        .end = "END",
        .auto = "AUTO",
    };
};
