const Project = @import("project.zig").Project;

/// Represents the result of a get project request.
pub const GetProjectResult = struct {
    /// The project to get information about.
    project: ?Project,

    pub const json_field_names = .{
        .project = "project",
    };
};
