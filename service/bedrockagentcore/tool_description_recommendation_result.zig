const RecommendationResultConfigurationBundle = @import("recommendation_result_configuration_bundle.zig").RecommendationResultConfigurationBundle;
const ToolDescriptionOutput = @import("tool_description_output.zig").ToolDescriptionOutput;

/// The result of a tool description recommendation, containing optimized
/// descriptions.
pub const ToolDescriptionRecommendationResult = struct {
    /// The configuration bundle containing the recommended tool descriptions, if
    /// the input was sourced from a configuration bundle.
    configuration_bundle: ?RecommendationResultConfigurationBundle = null,

    /// The error code if the recommendation failed.
    error_code: ?[]const u8 = null,

    /// The error message if the recommendation failed.
    error_message: ?[]const u8 = null,

    /// The list of tools with their recommended descriptions.
    tools: ?[]const ToolDescriptionOutput = null,

    pub const json_field_names = .{
        .configuration_bundle = "configurationBundle",
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .tools = "tools",
    };
};
