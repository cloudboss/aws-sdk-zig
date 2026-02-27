pub const ResourceType = enum {
    portal,
    project,

    pub const json_field_names = .{
        .portal = "PORTAL",
        .project = "PROJECT",
    };
};
