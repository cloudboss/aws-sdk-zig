pub const ServiceFilterName = enum {
    namespace_id,
    resource_owner,

    pub const json_field_names = .{
        .namespace_id = "NAMESPACE_ID",
        .resource_owner = "RESOURCE_OWNER",
    };
};
