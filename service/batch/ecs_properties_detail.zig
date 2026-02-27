const EcsTaskDetails = @import("ecs_task_details.zig").EcsTaskDetails;

/// An object that contains the details for the Amazon ECS resources of a job.
pub const EcsPropertiesDetail = struct {
    /// The properties for the Amazon ECS task definition of a job.
    task_properties: ?[]const EcsTaskDetails,

    pub const json_field_names = .{
        .task_properties = "taskProperties",
    };
};
