const RepositoryProvider = @import("repository_provider.zig").RepositoryProvider;
const TemplateType = @import("template_type.zig").TemplateType;

/// The detail data for a template sync configuration.
pub const TemplateSyncConfig = struct {
    /// The repository branch.
    branch: []const u8,

    /// The repository name (for example, `myrepos/myrepo`).
    repository_name: []const u8,

    /// The repository provider.
    repository_provider: RepositoryProvider,

    /// A subdirectory path to your template bundle version.
    subdirectory: ?[]const u8,

    /// The template name.
    template_name: []const u8,

    /// The template type.
    template_type: TemplateType,

    pub const json_field_names = .{
        .branch = "branch",
        .repository_name = "repositoryName",
        .repository_provider = "repositoryProvider",
        .subdirectory = "subdirectory",
        .template_name = "templateName",
        .template_type = "templateType",
    };
};
