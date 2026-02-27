pub const ProfileStatus = enum {
    complete,
    deleting,
    updating,
    creating,
    deleted,
    failed,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .creating = "CREATING",
        .deleted = "DELETED",
        .failed = "FAILED",
    };
};
