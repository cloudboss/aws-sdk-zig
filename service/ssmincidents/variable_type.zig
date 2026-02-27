pub const VariableType = enum {
    incident_record_arn,
    involved_resources,

    pub const json_field_names = .{
        .incident_record_arn = "INCIDENT_RECORD_ARN",
        .involved_resources = "INVOLVED_RESOURCES",
    };
};
