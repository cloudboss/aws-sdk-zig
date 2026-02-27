/// Placeholder documentation for InputState
pub const InputState = enum {
    creating,
    detached,
    attached,
    deleting,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .detached = "DETACHED",
        .attached = "ATTACHED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
