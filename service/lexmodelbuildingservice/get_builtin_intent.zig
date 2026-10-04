const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BuiltinIntentSlot = @import("builtin_intent_slot.zig").BuiltinIntentSlot;
const Locale = @import("locale.zig").Locale;

pub const GetBuiltinIntentInput = struct {
    /// The unique identifier for a built-in intent. To find the signature
    /// for an intent, see [Standard Built-in
    /// Intents](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/built-in-intent-ref/standard-intents) in the *Alexa Skills
    /// Kit*.
    signature: []const u8,

    pub const json_field_names = .{
        .signature = "signature",
    };
};

pub const GetBuiltinIntentOutput = struct {
    /// The unique identifier for a built-in intent.
    signature: ?[]const u8 = null,

    /// An array of `BuiltinIntentSlot` objects, one entry for
    /// each slot type in the intent.
    slots: ?[]const BuiltinIntentSlot = null,

    /// A list of locales that the intent supports.
    supported_locales: ?[]const Locale = null,

    pub const json_field_names = .{
        .signature = "signature",
        .slots = "slots",
        .supported_locales = "supportedLocales",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBuiltinIntentInput, options: CallOptions) !GetBuiltinIntentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetBuiltinIntentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/builtins/intents/");
    try path_buf.appendSlice(allocator, input.signature);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBuiltinIntentOutput {
    var result: GetBuiltinIntentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetBuiltinIntentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
