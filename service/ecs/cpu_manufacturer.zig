pub const CpuManufacturer = enum {
    intel,
    amd,
    amazon_web_services,

    pub const json_field_names = .{
        .intel = "INTEL",
        .amd = "AMD",
        .amazon_web_services = "AMAZON_WEB_SERVICES",
    };
};
