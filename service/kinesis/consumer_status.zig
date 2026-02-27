pub const ConsumerStatus = enum {
    creating,
    deleting,
    active,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
    };
};
