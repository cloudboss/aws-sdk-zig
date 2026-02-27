const RepositoryProvider = @import("repository_provider.zig").RepositoryProvider;

/// Detailed data of the service sync configuration.
pub const ServiceSyncConfig = struct {
    /// The name of the code repository branch that holds the service code Proton
    /// will sync
    /// with.
    branch: []const u8,

    /// The file path to the service sync configuration file.
    file_path: []const u8,

    /// The name of the code repository that holds the service code Proton will sync
    /// with.
    repository_name: []const u8,

    /// The name of the repository provider that holds the repository Proton will
    /// sync
    /// with.
    repository_provider: RepositoryProvider,

    /// The name of the service that the service instance is added to.
    service_name: []const u8,

    pub const json_field_names = .{
        .branch = "branch",
        .file_path = "filePath",
        .repository_name = "repositoryName",
        .repository_provider = "repositoryProvider",
        .service_name = "serviceName",
    };
};
