/// M2ts Es Rate In Pes
pub const M2tsEsRateInPes = enum {
    exclude,
    include,

    pub const json_field_names = .{
        .exclude = "EXCLUDE",
        .include = "INCLUDE",
    };
};
