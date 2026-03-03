const ChatResponseConfigurationStatus = @import("chat_response_configuration_status.zig").ChatResponseConfigurationStatus;

/// Configuration details that define how Amazon Q Business generates and
/// formats responses to user queries in chat interactions. This configuration
/// allows administrators to customize response characteristics to meet specific
/// organizational needs and communication standards.
pub const ChatResponseConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the chat response configuration, which
    /// uniquely identifies the resource across all Amazon Web Services services and
    /// accounts.
    chat_response_configuration_arn: []const u8,

    /// A unique identifier for your chat response configuration settings, used to
    /// reference and manage the configuration within the Amazon Q Business service.
    chat_response_configuration_id: []const u8,

    /// The timestamp indicating when the chat response configuration was initially
    /// created, useful for tracking the lifecycle of configuration resources.
    created_at: ?i64 = null,

    /// A human-readable name for the chat response configuration, making it easier
    /// to identify and manage multiple configurations within an organization.
    display_name: []const u8,

    /// A summary of the response configuration settings, providing a concise
    /// overview of the key parameters that define how responses are generated and
    /// formatted.
    response_configuration_summary: ?[]const u8 = null,

    /// The current status of the chat response configuration, indicating whether it
    /// is active, pending, or in another state that affects its availability for
    /// use in chat interactions.
    status: ChatResponseConfigurationStatus,

    /// The timestamp indicating when the chat response configuration was last
    /// modified, helping administrators track changes and maintain version
    /// awareness.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .chat_response_configuration_arn = "chatResponseConfigurationArn",
        .chat_response_configuration_id = "chatResponseConfigurationId",
        .created_at = "createdAt",
        .display_name = "displayName",
        .response_configuration_summary = "responseConfigurationSummary",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
