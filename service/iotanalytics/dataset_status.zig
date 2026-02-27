pub const DatasetStatus = enum {
    creating,
    active,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
    };
};
