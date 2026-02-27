pub const ListEventTypesFilterName = enum {
    resource_type,
    service_name,

    pub const json_field_names = .{
        .resource_type = "RESOURCE_TYPE",
        .service_name = "SERVICE_NAME",
    };
};
