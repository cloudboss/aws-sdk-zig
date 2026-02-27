pub const ResourceTagSource = enum {
    project,
    project_profile,

    pub const json_field_names = .{
        .project = "PROJECT",
        .project_profile = "PROJECT_PROFILE",
    };
};
