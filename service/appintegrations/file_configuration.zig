const aws = @import("aws");

/// The configuration for what files should be pulled from the source.
pub const FileConfiguration = struct {
    /// Restrictions for what files should be pulled from the source.
    filters: ?[]const aws.map.MapEntry([]const []const u8),

    /// Identifiers for the source folders to pull all files from recursively.
    folders: []const []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .folders = "Folders",
    };
};
