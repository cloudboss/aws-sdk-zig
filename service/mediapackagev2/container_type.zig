pub const ContainerType = enum {
    ts,
    cmaf,
    ism,

    pub const json_field_names = .{
        .ts = "TS",
        .cmaf = "CMAF",
        .ism = "ISM",
    };
};
