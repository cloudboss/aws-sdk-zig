/// Basic information about the plugin.
pub const PluginProperties = struct {
    /// The name of the class to load.
    class_name: ?[]const u8 = null,

    /// The description of the plugin.
    description: ?[]const u8 = null,

    /// The name of the plugin.
    name: ?[]const u8 = null,

    /// The uncompressed size of the plugin.
    uncompressed_size_in_bytes: ?i64 = null,

    /// The version of the plugin.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .class_name = "ClassName",
        .description = "Description",
        .name = "Name",
        .uncompressed_size_in_bytes = "UncompressedSizeInBytes",
        .version = "Version",
    };
};
