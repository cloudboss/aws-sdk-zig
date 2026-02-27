pub const ConnectionAliasState = enum {
    creating,
    created,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .deleting = "DELETING",
    };
};
