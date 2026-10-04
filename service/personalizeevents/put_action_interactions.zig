const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionInteraction = @import("action_interaction.zig").ActionInteraction;

pub const PutActionInteractionsInput = struct {
    /// A list of action interaction events from the session.
    action_interactions: []const ActionInteraction,

    /// The ID of your action interaction event tracker. When you create an Action
    /// interactions dataset, Amazon Personalize creates an
    /// action interaction event tracker for you. For more information, see [Action
    /// interaction event tracker
    /// ID](https://docs.aws.amazon.com/personalize/latest/dg/action-interaction-tracker-id.html).
    tracking_id: []const u8,

    pub const json_field_names = .{
        .action_interactions = "actionInteractions",
        .tracking_id = "trackingId",
    };
};

pub const PutActionInteractionsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutActionInteractionsInput, options: CallOptions) !PutActionInteractionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "personalize", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutActionInteractionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize-events", "Personalize Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/action-interactions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actionInteractions\":");
    try aws.json.writeValue(@TypeOf(input.action_interactions), input.action_interactions, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"trackingId\":");
    try aws.json.writeValue(@TypeOf(input.tracking_id), input.tracking_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutActionInteractionsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutActionInteractionsOutput = .{};

    return result;
}
