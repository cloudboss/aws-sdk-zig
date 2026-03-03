const InvocationLogSource = @import("invocation_log_source.zig").InvocationLogSource;
const RequestMetadataFilters = @import("request_metadata_filters.zig").RequestMetadataFilters;

/// Settings for using invocation logs to customize a model.
pub const InvocationLogsConfig = struct {
    /// The source of the invocation logs.
    invocation_log_source: InvocationLogSource,

    /// Rules for filtering invocation logs based on request metadata.
    request_metadata_filters: ?RequestMetadataFilters = null,

    /// Whether to use the model's response for training, or just the prompt. The
    /// default value is `False`.
    use_prompt_response: bool = false,

    pub const json_field_names = .{
        .invocation_log_source = "invocationLogSource",
        .request_metadata_filters = "requestMetadataFilters",
        .use_prompt_response = "usePromptResponse",
    };
};
