/// A plugin is an Amazon Web Services resource that contains the code that
/// defines a connector's logic.
pub const CustomPlugin = struct {
    /// The Amazon Resource Name (ARN) of the custom plugin.
    custom_plugin_arn: []const u8,

    /// The revision of the custom plugin.
    revision: i64 = 0,

    pub const json_field_names = .{
        .custom_plugin_arn = "customPluginArn",
        .revision = "revision",
    };
};
