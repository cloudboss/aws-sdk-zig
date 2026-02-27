pub const Platform = enum {
    web,
    web_dynamic,
    web_compute,

    pub const json_field_names = .{
        .web = "WEB",
        .web_dynamic = "WEB_DYNAMIC",
        .web_compute = "WEB_COMPUTE",
    };
};
