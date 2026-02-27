pub const ExperienceStatus = enum {
    creating,
    active,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .failed = "FAILED",
    };
};
