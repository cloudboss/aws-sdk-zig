/// A file system, created by you in Amazon EFS, that you assign to a user
/// profile or space for an Amazon SageMaker AI Domain. Permitted users can
/// access this file system in Amazon SageMaker AI Studio.
pub const EFSFileSystem = struct {
    /// The ID of your Amazon EFS file system.
    file_system_id: []const u8,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
    };
};
