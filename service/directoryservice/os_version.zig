pub const OSVersion = enum {
    version_2012,
    version_2019,

    pub const json_field_names = .{
        .version_2012 = "VERSION_2012",
        .version_2019 = "VERSION_2019",
    };
};
