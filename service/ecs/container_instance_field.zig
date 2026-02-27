pub const ContainerInstanceField = enum {
    tags,
    container_instance_health,

    pub const json_field_names = .{
        .tags = "TAGS",
        .container_instance_health = "CONTAINER_INSTANCE_HEALTH",
    };
};
