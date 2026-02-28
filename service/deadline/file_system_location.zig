const FileSystemLocationType = @import("file_system_location_type.zig").FileSystemLocationType;

/// The details of the file system location for the resource.
pub const FileSystemLocation = struct {
    /// The location name.
    name: []const u8,

    /// The file path.
    path: []const u8,

    /// The type of file.
    type: FileSystemLocationType,

    pub const json_field_names = .{
        .name = "name",
        .path = "path",
        .type = "type",
    };
};
