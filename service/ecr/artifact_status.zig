pub const ArtifactStatus = enum {
    active,
    archived,
    activating,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .archived = "ARCHIVED",
        .activating = "ACTIVATING",
    };
};
