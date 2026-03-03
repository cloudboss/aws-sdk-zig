const VersionControl = @import("version_control.zig").VersionControl;

/// Object containing source code information that is linked to an application
/// component.
pub const SourceCode = struct {
    /// The repository name for the source code.
    location: ?[]const u8 = null,

    /// The name of the project.
    project_name: ?[]const u8 = null,

    /// The branch of the source code.
    source_version: ?[]const u8 = null,

    /// The type of repository to use for the source code.
    version_control: ?VersionControl = null,

    pub const json_field_names = .{
        .location = "location",
        .project_name = "projectName",
        .source_version = "sourceVersion",
        .version_control = "versionControl",
    };
};
