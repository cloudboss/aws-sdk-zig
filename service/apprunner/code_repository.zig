const CodeConfiguration = @import("code_configuration.zig").CodeConfiguration;
const SourceCodeVersion = @import("source_code_version.zig").SourceCodeVersion;

/// Describes a source code repository.
pub const CodeRepository = struct {
    /// Configuration for building and running the service from a source code
    /// repository.
    ///
    /// `CodeConfiguration` is required only for `CreateService` request.
    code_configuration: ?CodeConfiguration = null,

    /// The location of the repository that contains the source code.
    repository_url: []const u8,

    /// The version that should be used within the source code repository.
    source_code_version: SourceCodeVersion,

    /// The path of the directory that stores source code and configuration files.
    /// The build and start commands also execute from here. The path is absolute
    /// from root and, if not specified, defaults to the repository root.
    source_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_configuration = "CodeConfiguration",
        .repository_url = "RepositoryUrl",
        .source_code_version = "SourceCodeVersion",
        .source_directory = "SourceDirectory",
    };
};
