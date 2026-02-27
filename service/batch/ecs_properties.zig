const EcsTaskProperties = @import("ecs_task_properties.zig").EcsTaskProperties;

/// An object that contains the properties for the Amazon ECS resources of a
/// job.
pub const EcsProperties = struct {
    /// An object that contains the properties for the Amazon ECS task definition of
    /// a job.
    ///
    /// This object is currently limited to one task element. However, the task
    /// element can run up to 10 containers.
    task_properties: []const EcsTaskProperties,

    pub const json_field_names = .{
        .task_properties = "taskProperties",
    };
};
