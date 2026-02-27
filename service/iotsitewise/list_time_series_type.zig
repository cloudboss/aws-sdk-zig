pub const ListTimeSeriesType = enum {
    associated,
    disassociated,

    pub const json_field_names = .{
        .associated = "ASSOCIATED",
        .disassociated = "DISASSOCIATED",
    };
};
