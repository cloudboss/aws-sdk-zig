pub const ContainerType = enum {
    docker,

    pub const json_field_names = .{
        .docker = "DOCKER",
    };
};
