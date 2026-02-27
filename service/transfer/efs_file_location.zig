/// Specifies the details for the file location for the file that's being used
/// in the workflow. Only applicable if you are using Amazon Elastic File
/// Systems (Amazon EFS) for storage.
pub const EfsFileLocation = struct {
    /// The identifier of the file system, assigned by Amazon EFS.
    file_system_id: ?[]const u8,

    /// The pathname for the folder being used by a workflow.
    path: ?[]const u8,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .path = "Path",
    };
};
