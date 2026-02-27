pub const CEStatus = enum {
    creating,
    updating,
    deleting,
    deleted,
    valid,
    invalid,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .valid = "VALID",
        .invalid = "INVALID",
    };
};
