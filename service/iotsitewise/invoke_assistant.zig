const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResponseStream = @import("response_stream.zig").ResponseStream;

pub const InvokeAssistantInput = struct {
    /// The ID assigned to a conversation. IoT SiteWise automatically generates a
    /// unique ID for you, and this parameter is never required.
    /// However, if you prefer to have your own ID, you must specify it here in UUID
    /// format. If you specify your own ID, it must be globally unique.
    conversation_id: ?[]const u8 = null,

    /// Specifies if to turn trace on or not. It is used to track the SiteWise
    /// Assistant's
    /// reasoning, and data access process.
    enable_trace: bool = false,

    /// A text message sent to the SiteWise Assistant by the user.
    message: []const u8,

    pub const json_field_names = .{
        .conversation_id = "conversationId",
        .enable_trace = "enableTrace",
        .message = "message",
    };
};

pub const InvokeAssistantOutput = struct {
    body: ?ResponseStream = null,

    /// The ID of the conversation, in UUID format. This ID uniquely identifies the
    /// conversation within IoT SiteWise.
    conversation_id: []const u8,

    pub const json_field_names = .{
        .body = "body",
        .conversation_id = "conversationId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeAssistantInput, options: Options) !InvokeAssistantOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
