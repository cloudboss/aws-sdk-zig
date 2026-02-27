const aws = @import("aws");

const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const ResponseConfiguration = @import("response_configuration.zig").ResponseConfiguration;
const ChatResponseConfigurationStatus = @import("chat_response_configuration_status.zig").ChatResponseConfigurationStatus;

/// Detailed information about a chat response configuration, including
/// comprehensive settings and parameters that define how Amazon Q Business
/// generates and formats responses.
pub const ChatResponseConfigurationDetail = struct {
    @"error": ?ErrorDetail,

    /// A collection of specific response configuration settings that collectively
    /// define how responses are generated, formatted, and presented to users in
    /// chat interactions.
    response_configurations: ?[]const aws.map.MapEntry(ResponseConfiguration),

    /// A summary of the response configuration details, providing a concise
    /// overview of the key parameters and settings that define the response
    /// generation behavior.
    response_configuration_summary: ?[]const u8,

    /// The current status of the chat response configuration, indicating whether it
    /// is active, pending, or in another state that affects its availability for
    /// use.
    status: ?ChatResponseConfigurationStatus,

    /// The timestamp indicating when the detailed chat response configuration was
    /// last modified, helping administrators track changes and maintain version
    /// awareness.
    updated_at: ?i64,

    pub const json_field_names = .{
        .@"error" = "error",
        .response_configurations = "responseConfigurations",
        .response_configuration_summary = "responseConfigurationSummary",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
