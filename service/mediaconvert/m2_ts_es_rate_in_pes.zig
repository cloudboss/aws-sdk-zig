/// Controls whether to include the ES Rate field in the PES header.
pub const M2tsEsRateInPes = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };
};
