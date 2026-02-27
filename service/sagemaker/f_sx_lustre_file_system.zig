/// A custom file system in Amazon FSx for Lustre.
pub const FSxLustreFileSystem = struct {
    /// Amazon FSx for Lustre file system ID.
    file_system_id: []const u8,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
    };
};
