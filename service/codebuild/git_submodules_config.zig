/// Information about the Git submodules configuration for an CodeBuild build
/// project.
pub const GitSubmodulesConfig = struct {
    /// Set to true to fetch Git submodules for your CodeBuild build project.
    fetch_submodules: bool,

    pub const json_field_names = .{
        .fetch_submodules = "fetchSubmodules",
    };
};
