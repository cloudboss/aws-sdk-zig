/// Dependency package that may be required for the project code to run.
pub const CodegenDependency = struct {
    /// Determines if the dependency package is using Semantic versioning. If set to
    /// true, it indicates that the dependency package uses Semantic versioning.
    is_sem_ver: ?bool = null,

    /// Name of the dependency package.
    name: ?[]const u8 = null,

    /// Indicates the reason to include the dependency package in your project code.
    reason: ?[]const u8 = null,

    /// Indicates the version of the supported dependency package.
    supported_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_sem_ver = "isSemVer",
        .name = "name",
        .reason = "reason",
        .supported_version = "supportedVersion",
    };
};
