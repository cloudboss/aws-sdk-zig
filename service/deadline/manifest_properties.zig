const PathFormat = @import("path_format.zig").PathFormat;

/// The details of the manifest that links a job's source information.
pub const ManifestProperties = struct {
    /// The file system location name.
    file_system_location_name: ?[]const u8 = null,

    /// The hash value of the file.
    input_manifest_hash: ?[]const u8 = null,

    /// The file path.
    input_manifest_path: ?[]const u8 = null,

    /// The file path relative to the directory.
    output_relative_directories: ?[]const []const u8 = null,

    /// The file's root path.
    root_path: []const u8,

    /// The format of the root path.
    root_path_format: PathFormat,

    pub const json_field_names = .{
        .file_system_location_name = "fileSystemLocationName",
        .input_manifest_hash = "inputManifestHash",
        .input_manifest_path = "inputManifestPath",
        .output_relative_directories = "outputRelativeDirectories",
        .root_path = "rootPath",
        .root_path_format = "rootPathFormat",
    };
};
