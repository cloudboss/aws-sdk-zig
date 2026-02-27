pub const ResolverEndpointStatus = enum {
    creating,
    operational,
    updating,
    auto_recovering,
    action_needed,
    deleting,

    pub const json_field_names = .{
        .creating = "Creating",
        .operational = "Operational",
        .updating = "Updating",
        .auto_recovering = "AutoRecovering",
        .action_needed = "ActionNeeded",
        .deleting = "Deleting",
    };
};
