/// Returns information about a submodule reference in a repository folder.
pub const SubModule = struct {
    /// The fully qualified path to the folder that contains the reference to the
    /// submodule.
    absolute_path: ?[]const u8 = null,

    /// The commit ID that contains the reference to the submodule.
    commit_id: ?[]const u8 = null,

    /// The relative path of the submodule from the folder where the query
    /// originated.
    relative_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .absolute_path = "absolutePath",
        .commit_id = "commitId",
        .relative_path = "relativePath",
    };
};
