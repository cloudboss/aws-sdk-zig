const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConversationMode = @import("conversation_mode.zig").ConversationMode;
const StartConversationRequestEventStream = @import("start_conversation_request_event_stream.zig").StartConversationRequestEventStream;
const StartConversationResponseEventStream = @import("start_conversation_response_event_stream.zig").StartConversationResponseEventStream;

pub const StartConversationInput = struct {
    /// The alias identifier in use for the bot that processes the
    /// request.
    bot_alias_id: []const u8,

    /// The identifier of the bot to process the request.
    bot_id: []const u8,

    /// The conversation type that you are using the Amazon Lex V2. If the
    /// conversation mode is `AUDIO` you can send both audio and
    /// DTMF information. If the mode is `TEXT` you can only send
    /// text.
    conversation_mode: ?ConversationMode = null,

    /// The locale where the session is in use.
    locale_id: []const u8,

    /// Represents the stream of events to Amazon Lex V2 from your application. The
    /// events are encoded as HTTP/2 data frames.
    request_event_stream: StartConversationRequestEventStream,

    /// The identifier of the user session that is having the
    /// conversation.
    session_id: []const u8,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .conversation_mode = "conversationMode",
        .locale_id = "localeId",
        .request_event_stream = "requestEventStream",
        .session_id = "sessionId",
    };
};

pub const StartConversationOutput = struct {
    /// Represents the stream of events from Amazon Lex V2 to your application. The
    /// events are encoded as HTTP/2 data frames.
    response_event_stream: ?StartConversationResponseEventStream = null,

    pub const json_field_names = .{
        .response_event_stream = "responseEventStream",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartConversationInput, options: Options) !StartConversationOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    // Requires HTTP/2 bidirectional streaming
    return error.EventStreamNotSupported;
}
