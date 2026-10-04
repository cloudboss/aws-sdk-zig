const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RetrieveAndGenerateConfiguration = @import("retrieve_and_generate_configuration.zig").RetrieveAndGenerateConfiguration;
const RetrieveAndGenerateSessionConfiguration = @import("retrieve_and_generate_session_configuration.zig").RetrieveAndGenerateSessionConfiguration;
const Citation = @import("citation.zig").Citation;
const GuadrailAction = @import("guadrail_action.zig").GuadrailAction;

pub const RetrieveAndGenerateInput = @import("retrieve_and_generate_request.zig").RetrieveAndGenerateRequest;

pub const RetrieveAndGenerateOutput = @import("retrieve_and_generate_response.zig").RetrieveAndGenerateResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetrieveAndGenerateInput, options: CallOptions) !RetrieveAndGenerateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RetrieveAndGenerateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/retrieveAndGenerate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"input\":");
    try aws.json.writeValue(@TypeOf(input.input), input.input, allocator, &body_buf);
    has_prev = true;
    if (input.retrieve_and_generate_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retrieveAndGenerateConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RetrieveAndGenerateOutput {
    var result: RetrieveAndGenerateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RetrieveAndGenerateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
