pub const OcsfMapField = enum {
    resources_tags,
    compliance_control_parameters,
    databucket_tags,
    finding_info_tags,

    pub const json_field_names = .{
        .resources_tags = "RESOURCES_TAGS",
        .compliance_control_parameters = "COMPLIANCE_CONTROL_PARAMETERS",
        .databucket_tags = "DATABUCKET_TAGS",
        .finding_info_tags = "FINDING_INFO_TAGS",
    };
};
