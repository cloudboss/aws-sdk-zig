pub const InstancePropertyFilterKey = enum {
    instance_ids,
    agent_version,
    ping_status,
    platform_types,
    document_name,
    activation_ids,
    iam_role,
    resource_type,
    association_status,

    pub const json_field_names = .{
        .instance_ids = "INSTANCE_IDS",
        .agent_version = "AGENT_VERSION",
        .ping_status = "PING_STATUS",
        .platform_types = "PLATFORM_TYPES",
        .document_name = "DOCUMENT_NAME",
        .activation_ids = "ACTIVATION_IDS",
        .iam_role = "IAM_ROLE",
        .resource_type = "RESOURCE_TYPE",
        .association_status = "ASSOCIATION_STATUS",
    };
};
