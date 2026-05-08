const ConfigurationBundleToolEntry = @import("configuration_bundle_tool_entry.zig").ConfigurationBundleToolEntry;

/// Tool descriptions sourced from a configuration bundle version.
pub const ToolDescriptionConfigurationBundle = struct {
    /// The Amazon Resource Name (ARN) of the configuration bundle.
    bundle_arn: []const u8,

    /// The list of tool entries mapping tool names to their JSON paths within the
    /// bundle.
    tools: []const ConfigurationBundleToolEntry,

    /// The version identifier of the configuration bundle.
    version_id: []const u8,

    pub const json_field_names = .{
        .bundle_arn = "bundleArn",
        .tools = "tools",
        .version_id = "versionId",
    };
};
