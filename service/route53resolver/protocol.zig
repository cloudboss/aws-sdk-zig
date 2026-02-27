pub const Protocol = enum {
    doh,
    do53,
    dohfips,

    pub const json_field_names = .{
        .doh = "DOH",
        .do53 = "DO53",
        .dohfips = "DOHFIPS",
    };
};
