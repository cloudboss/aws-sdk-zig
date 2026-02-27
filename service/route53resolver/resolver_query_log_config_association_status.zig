pub const ResolverQueryLogConfigAssociationStatus = enum {
    creating,
    active,
    action_needed,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "Creating",
        .active = "Active",
        .action_needed = "ActionNeeded",
        .deleting = "Deleting",
        .failed = "Failed",
    };
};
