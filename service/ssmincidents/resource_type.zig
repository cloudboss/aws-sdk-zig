pub const ResourceType = enum {
    response_plan,
    incident_record,
    timeline_event,
    replication_set,
    resource_policy,

    pub const json_field_names = .{
        .response_plan = "RESPONSE_PLAN",
        .incident_record = "INCIDENT_RECORD",
        .timeline_event = "TIMELINE_EVENT",
        .replication_set = "REPLICATION_SET",
        .resource_policy = "RESOURCE_POLICY",
    };
};
