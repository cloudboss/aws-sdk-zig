pub const PowerConnector = enum {
    l6_30_p,
    iec309,
    ah530_p7_w,
    ah532_p6_w,
    cs8365_c,

    pub const json_field_names = .{
        .l6_30_p = "L6_30P",
        .iec309 = "IEC309",
        .ah530_p7_w = "AH530P7W",
        .ah532_p6_w = "AH532P6W",
        .cs8365_c = "CS8365C",
    };
};
