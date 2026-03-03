/// Object containing source code information that is linked to an application
/// component.
pub const SourceCodeRepository = struct {
    /// The branch of the source code.
    branch: ?[]const u8 = null,

    /// The name of the project.
    project_name: ?[]const u8 = null,

    /// The repository name for the source code.
    repository: ?[]const u8 = null,

    /// The type of repository to use for the source code.
    version_control_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .branch = "branch",
        .project_name = "projectName",
        .repository = "repository",
        .version_control_type = "versionControlType",
    };
};
