/// Maps a tool name to its JSON path within a configuration bundle.
pub const ConfigurationBundleToolEntry = struct {
    /// The JSON path within the configuration bundle's components that contains the
    /// tool description.
    tool_description_json_path: []const u8,

    /// The name of the tool.
    tool_name: []const u8,

    pub const json_field_names = .{
        .tool_description_json_path = "toolDescriptionJsonPath",
        .tool_name = "toolName",
    };
};
