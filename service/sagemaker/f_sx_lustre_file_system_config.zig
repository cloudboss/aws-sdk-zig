/// The settings for assigning a custom Amazon FSx for Lustre file system to a
/// user profile or space for an Amazon SageMaker Domain.
pub const FSxLustreFileSystemConfig = struct {
    /// The globally unique, 17-digit, ID of the file system, assigned by Amazon FSx
    /// for Lustre.
    file_system_id: []const u8,

    /// The path to the file system directory that is accessible in Amazon SageMaker
    /// Studio. Permitted users can access only this directory and below.
    file_system_path: ?[]const u8,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .file_system_path = "FileSystemPath",
    };
};
