pub const ObjectTypeEnum = enum {
    assessment,
    control_set,
    control,
    delegation,
    assessment_report,

    pub const json_field_names = .{
        .assessment = "ASSESSMENT",
        .control_set = "CONTROL_SET",
        .control = "CONTROL",
        .delegation = "DELEGATION",
        .assessment_report = "ASSESSMENT_REPORT",
    };
};
