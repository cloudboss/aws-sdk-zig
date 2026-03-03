/// Information about a project in a space.
pub const ProjectInformation = struct {
    /// The name of the project in the space.
    name: ?[]const u8 = null,

    /// The system-generated unique ID of the project.
    project_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .project_id = "projectId",
    };
};
