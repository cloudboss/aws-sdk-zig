pub const OutputFormat = enum {
    raw,
    extracted,

    pub const json_field_names = .{
        .raw = "RAW",
        .extracted = "EXTRACTED",
    };
};
