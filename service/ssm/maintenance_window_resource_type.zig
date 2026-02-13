pub const MaintenanceWindowResourceType = enum {
    instance,
    resource_group,

    pub const json_field_names = .{
        .instance = "Instance",
        .resource_group = "ResourceGroup",
    };
};
