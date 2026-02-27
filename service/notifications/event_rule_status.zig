pub const EventRuleStatus = enum {
    /// EventRule is processing events. Any call can be executed.
    active,
    /// EventRule is in a bad state and may not be processing events. Any call can
    /// be executed.
    inactive,
    /// This EventRule is being created. Only GET/LIST calls can be executed.
    creating,
    /// This EventRule is being updated. Only GET/LIST calls can be executed.
    updating,
    /// This EventRule is being deleted. Only GET/LIST calls can be executed.
    deleting,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
    };
};
