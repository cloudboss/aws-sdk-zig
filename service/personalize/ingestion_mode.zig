pub const IngestionMode = enum {
    bulk,
    put,
    all,

    pub const json_field_names = .{
        .bulk = "BULK",
        .put = "PUT",
        .all = "ALL",
    };
};
