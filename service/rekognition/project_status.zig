pub const ProjectStatus = enum {
    creating,
    created,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .deleting = "DELETING",
    };
};
