const Project = @import("project.zig").Project;

/// Represents the result of a create project request.
pub const CreateProjectResult = struct {
    /// The newly created project.
    project: ?Project = null,

    pub const json_field_names = .{
        .project = "project",
    };
};
