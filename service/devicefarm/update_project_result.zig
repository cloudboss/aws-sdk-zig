const Project = @import("project.zig").Project;

/// Represents the result of an update project request.
pub const UpdateProjectResult = struct {
    /// The project to update.
    project: ?Project = null,

    pub const json_field_names = .{
        .project = "project",
    };
};
