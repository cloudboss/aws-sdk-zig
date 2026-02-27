pub const OutpostResolverStatus = enum {
    creating,
    operational,
    updating,
    deleting,
    action_needed,
    failed_creation,
    failed_deletion,

    pub const json_field_names = .{
        .creating = "CREATING",
        .operational = "OPERATIONAL",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .action_needed = "ACTION_NEEDED",
        .failed_creation = "FAILED_CREATION",
        .failed_deletion = "FAILED_DELETION",
    };
};
