pub const DnsProtocol = enum {
    do53,
    doh,
    dot,

    pub const json_field_names = .{
        .do53 = "DO53",
        .doh = "DOH",
        .dot = "DOT",
    };
};
