/// Contains details about a task that failed to start during an execution.
pub const TaskStartFailedEventDetails = struct {
    /// A more detailed explanation of the cause of the failure.
    cause: ?[]const u8 = null,

    /// The error code of the failure.
    @"error": ?[]const u8 = null,

    /// The action of the resource called by a task state.
    resource: []const u8,

    /// The service name of the resource in a task state.
    resource_type: []const u8,

    pub const json_field_names = .{
        .cause = "cause",
        .@"error" = "error",
        .resource = "resource",
        .resource_type = "resourceType",
    };
};
