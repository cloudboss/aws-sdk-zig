pub const CdcPropagateTags = enum {
    table,
    none,

    pub const json_field_names = .{
        .table = "TABLE",
        .none = "NONE",
    };
};
