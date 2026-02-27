pub const TableTotalsScrollStatus = enum {
    pinned,
    scrolled,

    pub const json_field_names = .{
        .pinned = "PINNED",
        .scrolled = "SCROLLED",
    };
};
