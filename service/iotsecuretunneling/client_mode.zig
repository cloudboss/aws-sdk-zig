pub const ClientMode = enum {
    source,
    destination,
    all,

    pub const json_field_names = .{
        .source = "SOURCE",
        .destination = "DESTINATION",
        .all = "ALL",
    };
};
