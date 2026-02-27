pub const X12Version = enum {
    version_4010,
    version_4030,
    version_4050,
    version_4060,
    version_5010,
    version_5010_hipaa,

    pub const json_field_names = .{
        .version_4010 = "VERSION_4010",
        .version_4030 = "VERSION_4030",
        .version_4050 = "VERSION_4050",
        .version_4060 = "VERSION_4060",
        .version_5010 = "VERSION_5010",
        .version_5010_hipaa = "VERSION_5010_HIPAA",
    };
};
