/// Provides information about the file paths that were affected by the threat.
pub const FilePaths = struct {
    /// The name of the infected or suspicious file corresponding to the hash.
    ///
    /// Length Constraints: Minimum of 1 length. Maximum of 128 length.
    file_name: ?[]const u8,

    /// Path to the infected or suspicious file on the resource it was detected on.
    ///
    /// Length Constraints: Minimum of 1 length. Maximum of 128 length.
    file_path: ?[]const u8,

    /// The hash value for the infected or suspicious file.
    ///
    /// Length Constraints: Minimum of 1 length. Maximum of 128 length.
    hash: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the resource on which the threat was
    /// detected.
    ///
    /// Length Constraints: Minimum of 1 length. Maximum of 128 length.
    resource_id: ?[]const u8,

    pub const json_field_names = .{
        .file_name = "FileName",
        .file_path = "FilePath",
        .hash = "Hash",
        .resource_id = "ResourceId",
    };
};
