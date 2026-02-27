pub const RecordType = enum {
    srv,
    a,
    aaaa,
    cname,

    pub const json_field_names = .{
        .srv = "SRV",
        .a = "A",
        .aaaa = "AAAA",
        .cname = "CNAME",
    };
};
