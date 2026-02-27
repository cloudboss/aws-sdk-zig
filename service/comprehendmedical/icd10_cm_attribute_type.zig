pub const ICD10CMAttributeType = enum {
    acuity,
    direction,
    system_organ_site,
    quality,
    quantity,
    time_to_dx_name,
    time_expression,

    pub const json_field_names = .{
        .acuity = "ACUITY",
        .direction = "DIRECTION",
        .system_organ_site = "SYSTEM_ORGAN_SITE",
        .quality = "QUALITY",
        .quantity = "QUANTITY",
        .time_to_dx_name = "TIME_TO_DX_NAME",
        .time_expression = "TIME_EXPRESSION",
    };
};
