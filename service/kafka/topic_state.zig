/// The state of a topic request.
pub const TopicState = enum {
    creating,
    updating,
    deleting,
    active,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
    };
};
