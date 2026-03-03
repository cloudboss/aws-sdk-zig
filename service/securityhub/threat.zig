const FilePaths = @import("file_paths.zig").FilePaths;

/// Provides information about the threat detected in a security finding and the
/// file paths that were affected by the threat.
pub const Threat = struct {
    /// Provides information about the file paths that were affected by the threat.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 5 items.
    file_paths: ?[]const FilePaths = null,

    /// This total number of items in which the threat has been detected.
    item_count: ?i32 = null,

    /// The name of the threat.
    ///
    /// Length Constraints: Minimum of 1 length. Maximum of 128 length.
    name: ?[]const u8 = null,

    /// The severity of the threat.
    ///
    /// Length Constraints: Minimum of 1 length. Maximum of 128 length.
    severity: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_paths = "FilePaths",
        .item_count = "ItemCount",
        .name = "Name",
        .severity = "Severity",
    };
};
