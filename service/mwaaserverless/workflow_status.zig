pub const WorkflowStatus = enum {
    ready,
    deleting,

    pub const json_field_names = .{
        .ready = "READY",
        .deleting = "DELETING",
    };
};
