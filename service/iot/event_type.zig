pub const EventType = enum {
    thing,
    thing_group,
    thing_type,
    thing_group_membership,
    thing_group_hierarchy,
    thing_type_association,
    job,
    job_execution,
    policy,
    certificate,
    ca_certificate,

    pub const json_field_names = .{
        .thing = "THING",
        .thing_group = "THING_GROUP",
        .thing_type = "THING_TYPE",
        .thing_group_membership = "THING_GROUP_MEMBERSHIP",
        .thing_group_hierarchy = "THING_GROUP_HIERARCHY",
        .thing_type_association = "THING_TYPE_ASSOCIATION",
        .job = "JOB",
        .job_execution = "JOB_EXECUTION",
        .policy = "POLICY",
        .certificate = "CERTIFICATE",
        .ca_certificate = "CA_CERTIFICATE",
    };
};
