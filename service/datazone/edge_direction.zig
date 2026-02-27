pub const EdgeDirection = enum {
    upstream,
    downstream,

    pub const json_field_names = .{
        .upstream = "UPSTREAM",
        .downstream = "DOWNSTREAM",
    };
};
