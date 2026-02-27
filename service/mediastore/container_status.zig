pub const ContainerStatus = enum {
    active,
    creating,
    deleting,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .deleting = "DELETING",
    };
};
