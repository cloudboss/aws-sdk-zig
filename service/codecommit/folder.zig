/// Returns information about a folder in a repository.
pub const Folder = struct {
    /// The fully qualified path of the folder in the repository.
    absolute_path: ?[]const u8,

    /// The relative path of the specified folder from the folder where the query
    /// originated.
    relative_path: ?[]const u8,

    /// The full SHA-1 pointer of the tree information for the commit that contains
    /// the folder.
    tree_id: ?[]const u8,

    pub const json_field_names = .{
        .absolute_path = "absolutePath",
        .relative_path = "relativePath",
        .tree_id = "treeId",
    };
};
