pub const Schema = enum {
    ocsf,
    raw,

    pub const json_field_names = .{
        .ocsf = "OCSF",
        .raw = "RAW",
    };
};
