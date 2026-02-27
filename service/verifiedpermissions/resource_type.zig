pub const ResourceType = enum {
    identity_source,
    policy_store,
    policy,
    policy_template,
    schema,

    pub const json_field_names = .{
        .identity_source = "IDENTITY_SOURCE",
        .policy_store = "POLICY_STORE",
        .policy = "POLICY",
        .policy_template = "POLICY_TEMPLATE",
        .schema = "SCHEMA",
    };
};
