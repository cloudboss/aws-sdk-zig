pub const PivotTableSubtotalLevel = enum {
    all,
    custom,
    last,

    pub const json_field_names = .{
        .all = "ALL",
        .custom = "CUSTOM",
        .last = "LAST",
    };
};
