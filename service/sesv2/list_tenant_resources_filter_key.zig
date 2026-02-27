/// The key used to filter tenant resources. Currently, the only supported
/// filter key is `RESOURCE_TYPE`.
pub const ListTenantResourcesFilterKey = enum {
    resource_type,

    pub const json_field_names = .{
        .resource_type = "RESOURCE_TYPE",
    };
};
