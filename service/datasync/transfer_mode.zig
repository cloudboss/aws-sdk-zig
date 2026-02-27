pub const TransferMode = enum {
    changed,
    all,

    pub const json_field_names = .{
        .changed = "CHANGED",
        .all = "ALL",
    };
};
