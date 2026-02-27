/// Returns information about errors in a BatchGetCommits operation.
pub const BatchGetCommitsError = struct {
    /// A commit ID that either could not be found or was not in a valid format.
    commit_id: ?[]const u8,

    /// An error code that specifies whether the commit ID was not valid or not
    /// found.
    error_code: ?[]const u8,

    /// An error message that provides detail about why the commit ID either was not
    /// found or was not valid.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .commit_id = "commitId",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
