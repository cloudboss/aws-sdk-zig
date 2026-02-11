pub const RecursiveLoop = enum {
    allow,
    terminate,

    pub const json_field_names = .{
        .allow = "Allow",
        .terminate = "Terminate",
    };
};
