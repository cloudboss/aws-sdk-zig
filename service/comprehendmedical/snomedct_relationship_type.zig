pub const SNOMEDCTRelationshipType = enum {
    acuity,
    quality,
    test_value,
    test_units,
    direction,
    system_organ_site,
    test_unit,

    pub const json_field_names = .{
        .acuity = "ACUITY",
        .quality = "QUALITY",
        .test_value = "TEST_VALUE",
        .test_units = "TEST_UNITS",
        .direction = "DIRECTION",
        .system_organ_site = "SYSTEM_ORGAN_SITE",
        .test_unit = "TEST_UNIT",
    };
};
