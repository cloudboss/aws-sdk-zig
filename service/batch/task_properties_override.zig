const TaskContainerOverrides = @import("task_container_overrides.zig").TaskContainerOverrides;

/// An object that contains overrides for the task definition of a job.
pub const TaskPropertiesOverride = struct {
    /// The overrides for the container definition of a job.
    containers: ?[]const TaskContainerOverrides = null,

    pub const json_field_names = .{
        .containers = "containers",
    };
};
