pub const ImageType = enum {
    ami,
    docker,

    pub const json_field_names = .{
        .ami = "AMI",
        .docker = "DOCKER",
    };
};
