/// Basic information about the plugin.
pub const PluginProperties = struct {
    /// The name of the class to load.
    class_name: ?[]const u8,

    /// The description of the plugin.
    description: ?[]const u8,

    /// The name of the plugin.
    name: ?[]const u8,

    /// The uncompressed size of the plugin.
    uncompressed_size_in_bytes: ?i64,

    /// The version of the plugin.
    version: ?[]const u8,

    pub const json_field_names = .{
        .class_name = "ClassName",
        .description = "Description",
        .name = "Name",
        .uncompressed_size_in_bytes = "UncompressedSizeInBytes",
        .version = "Version",
    };
};
