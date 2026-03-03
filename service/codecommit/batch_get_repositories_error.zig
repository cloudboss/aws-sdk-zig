const BatchGetRepositoriesErrorCodeEnum = @import("batch_get_repositories_error_code_enum.zig").BatchGetRepositoriesErrorCodeEnum;

/// Returns information about errors in a BatchGetRepositories operation.
pub const BatchGetRepositoriesError = struct {
    /// An error code that specifies the type of failure.
    error_code: ?BatchGetRepositoriesErrorCodeEnum = null,

    /// An error message that provides detail about why the repository either was
    /// not found or was not in a valid state.
    error_message: ?[]const u8 = null,

    /// The ID of a repository that either could not be found or was not in a valid
    /// state.
    repository_id: ?[]const u8 = null,

    /// The name of a repository that either could not be found or was not in a
    /// valid state.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .repository_id = "repositoryId",
        .repository_name = "repositoryName",
    };
};
