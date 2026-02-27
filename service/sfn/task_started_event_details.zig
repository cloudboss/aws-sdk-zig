/// Contains details about the start of a task during an execution.
pub const TaskStartedEventDetails = struct {
    /// The action of the resource called by a task state.
    resource: []const u8,

    /// The service name of the resource in a task state.
    resource_type: []const u8,

    pub const json_field_names = .{
        .resource = "resource",
        .resource_type = "resourceType",
    };
};
