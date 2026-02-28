const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChatInputStream = @import("chat_input_stream.zig").ChatInputStream;
const ChatOutputStream = @import("chat_output_stream.zig").ChatOutputStream;

pub const ChatInput = struct {
    /// The identifier of the Amazon Q Business application linked to a streaming
    /// Amazon Q Business conversation.
    application_id: []const u8,

    /// A token that you provide to identify the chat input.
    client_token: ?[]const u8 = null,

    /// The identifier of the Amazon Q Business conversation.
    conversation_id: ?[]const u8 = null,

    /// The streaming input for the `Chat` API.
    input_stream: ?ChatInputStream = null,

    /// The identifier used to associate a user message with a AI generated
    /// response.
    parent_message_id: ?[]const u8 = null,

    /// The group names that a user associated with the chat input belongs to.
    user_groups: ?[]const []const u8 = null,

    /// The identifier of the user attached to the chat input.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .client_token = "clientToken",
        .conversation_id = "conversationId",
        .input_stream = "inputStream",
        .parent_message_id = "parentMessageId",
        .user_groups = "userGroups",
        .user_id = "userId",
    };
};

pub const ChatOutput = struct {
    /// The streaming output for the `Chat` API.
    output_stream: ?ChatOutputStream = null,

    pub const json_field_names = .{
        .output_stream = "outputStream",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ChatInput, options: Options) !ChatOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    // Requires HTTP/2 bidirectional streaming
    return error.EventStreamNotSupported;
}
