const CustomPluginState = @import("custom_plugin_state.zig").CustomPluginState;
const CustomPluginRevisionSummary = @import("custom_plugin_revision_summary.zig").CustomPluginRevisionSummary;

/// A summary of the custom plugin.
pub const CustomPluginSummary = struct {
    /// The time that the custom plugin was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the custom plugin.
    custom_plugin_arn: ?[]const u8 = null,

    /// The state of the custom plugin.
    custom_plugin_state: ?CustomPluginState = null,

    /// A description of the custom plugin.
    description: ?[]const u8 = null,

    /// The latest revision of the custom plugin.
    latest_revision: ?CustomPluginRevisionSummary = null,

    /// The name of the custom plugin.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .custom_plugin_arn = "customPluginArn",
        .custom_plugin_state = "customPluginState",
        .description = "description",
        .latest_revision = "latestRevision",
        .name = "name",
    };
};
