const ToolDescriptionConfigurationBundle = @import("tool_description_configuration_bundle.zig").ToolDescriptionConfigurationBundle;
const ToolDescriptionTextInput = @import("tool_description_text_input.zig").ToolDescriptionTextInput;

/// The source of tool descriptions, either inline text or from a configuration
/// bundle.
pub const ToolDescriptionSource = union(enum) {
    /// Tool descriptions sourced from a configuration bundle version.
    configuration_bundle: ?ToolDescriptionConfigurationBundle,
    /// Tool descriptions provided as inline text.
    tool_description_text: ?ToolDescriptionTextInput,

    pub const json_field_names = .{
        .configuration_bundle = "configurationBundle",
        .tool_description_text = "toolDescriptionText",
    };
};
