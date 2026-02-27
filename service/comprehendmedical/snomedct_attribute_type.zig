pub const SNOMEDCTAttributeType = enum {
    acuity,
    quality,
    direction,
    system_organ_site,
    test_value,
    test_unit,

    pub const json_field_names = .{
        .acuity = "ACUITY",
        .quality = "QUALITY",
        .direction = "DIRECTION",
        .system_organ_site = "SYSTEM_ORGAN_SITE",
        .test_value = "TEST_VALUE",
        .test_unit = "TEST_UNIT",
    };
};
