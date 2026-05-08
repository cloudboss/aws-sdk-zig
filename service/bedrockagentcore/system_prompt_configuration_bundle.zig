/// A system prompt sourced from a configuration bundle version.
pub const SystemPromptConfigurationBundle = struct {
    /// The Amazon Resource Name (ARN) of the configuration bundle.
    bundle_arn: []const u8,

    /// The JSON path within the configuration bundle that contains the system
    /// prompt.
    system_prompt_json_path: []const u8,

    /// The version identifier of the configuration bundle.
    version_id: []const u8,

    pub const json_field_names = .{
        .bundle_arn = "bundleArn",
        .system_prompt_json_path = "systemPromptJsonPath",
        .version_id = "versionId",
    };
};
