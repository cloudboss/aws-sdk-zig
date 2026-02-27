/// A Git repository that SageMaker AI automatically displays to users for
/// cloning in the JupyterServer application.
pub const CodeRepository = struct {
    /// The URL of the Git repository.
    repository_url: []const u8,

    pub const json_field_names = .{
        .repository_url = "RepositoryUrl",
    };
};
