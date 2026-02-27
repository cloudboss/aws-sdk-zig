const CustomPluginContentType = @import("custom_plugin_content_type.zig").CustomPluginContentType;
const CustomPluginFileDescription = @import("custom_plugin_file_description.zig").CustomPluginFileDescription;
const CustomPluginLocationDescription = @import("custom_plugin_location_description.zig").CustomPluginLocationDescription;

/// Details about the revision of a custom plugin.
pub const CustomPluginRevisionSummary = struct {
    /// The format of the plugin file.
    content_type: ?CustomPluginContentType,

    /// The time that the custom plugin was created.
    creation_time: ?i64,

    /// The description of the custom plugin.
    description: ?[]const u8,

    /// Details about the custom plugin file.
    file_description: ?CustomPluginFileDescription,

    /// Information about the location of the custom plugin.
    location: ?CustomPluginLocationDescription,

    /// The revision of the custom plugin.
    revision: i64 = 0,

    pub const json_field_names = .{
        .content_type = "contentType",
        .creation_time = "creationTime",
        .description = "description",
        .file_description = "fileDescription",
        .location = "location",
        .revision = "revision",
    };
};
