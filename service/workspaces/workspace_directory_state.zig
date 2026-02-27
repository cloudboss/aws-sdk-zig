pub const WorkspaceDirectoryState = enum {
    registering,
    registered,
    deregistering,
    deregistered,
    @"error",

    pub const json_field_names = .{
        .registering = "REGISTERING",
        .registered = "REGISTERED",
        .deregistering = "DEREGISTERING",
        .deregistered = "DEREGISTERED",
        .@"error" = "ERROR",
    };
};
