const TaskPropertiesOverride = @import("task_properties_override.zig").TaskPropertiesOverride;

/// An object that contains overrides for the Amazon ECS task definition of a
/// job.
pub const EcsPropertiesOverride = struct {
    /// The overrides for the Amazon ECS task definition of a job.
    ///
    /// This object is currently limited to one element.
    task_properties: ?[]const TaskPropertiesOverride = null,

    pub const json_field_names = .{
        .task_properties = "taskProperties",
    };
};
