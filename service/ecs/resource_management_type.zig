pub const ResourceManagementType = enum {
    customer,
    ecs,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .ecs = "ECS",
    };
};
