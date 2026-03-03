/// Details about a custom plugin.
pub const CustomPluginDescription = struct {
    /// The Amazon Resource Name (ARN) of the custom plugin.
    custom_plugin_arn: ?[]const u8 = null,

    /// The revision of the custom plugin.
    revision: i64 = 0,

    pub const json_field_names = .{
        .custom_plugin_arn = "customPluginArn",
        .revision = "revision",
    };
};
