pub const FlowDefinitionStatus = enum {
    initializing,
    active,
    failed,
    deleting,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .active = "ACTIVE",
        .failed = "FAILED",
        .deleting = "DELETING",
    };
};
