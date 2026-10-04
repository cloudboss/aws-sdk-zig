const AgentOutputMessageType = @import("agent_output_message_type.zig").AgentOutputMessageType;

/// Represents a response message from the agent during chat-based profile
/// customization.
pub const AgentOutputMessage = struct {
    /// The text of the agent's response.
    body: []const u8,

    /// A list of selectable options presented when the response type is `options`.
    options_list: ?[]const []const u8 = null,

    /// The type of output message, which indicates how to interpret the agent's
    /// response.
    @"type": AgentOutputMessageType,

    pub const json_field_names = .{
        .body = "Body",
        .options_list = "OptionsList",
        .@"type" = "Type",
    };
};
