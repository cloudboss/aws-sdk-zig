const DirectorySize = @import("directory_size.zig").DirectorySize;

/// Contains the directory size configuration for update operations.
pub const DirectorySizeUpdateSettings = struct {
    /// The target directory size for the update operation.
    directory_size: ?DirectorySize,

    pub const json_field_names = .{
        .directory_size = "DirectorySize",
    };
};
