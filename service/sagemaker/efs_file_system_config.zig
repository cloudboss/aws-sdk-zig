/// The settings for assigning a custom Amazon EFS file system to a user profile
/// or space for an Amazon SageMaker AI Domain.
pub const EFSFileSystemConfig = struct {
    /// The ID of your Amazon EFS file system.
    file_system_id: []const u8,

    /// The path to the file system directory that is accessible in Amazon SageMaker
    /// AI Studio. Permitted users can access only this directory and below.
    file_system_path: ?[]const u8,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .file_system_path = "FileSystemPath",
    };
};
