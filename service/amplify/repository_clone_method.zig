pub const RepositoryCloneMethod = enum {
    ssh,
    token,
    sigv4,

    pub const json_field_names = .{
        .ssh = "SSH",
        .token = "TOKEN",
        .sigv4 = "SIGV4",
    };
};
