const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateGuardrailVersionInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than once. If this token matches a previous request, Amazon Bedrock
    /// ignores the request, but does not return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html) in the *Amazon S3 User Guide*.
    client_request_token: ?[]const u8 = null,

    /// A description of the guardrail version.
    description: ?[]const u8 = null,

    /// The unique identifier of the guardrail. This can be an ID or the ARN.
    guardrail_identifier: []const u8,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .description = "description",
        .guardrail_identifier = "guardrailIdentifier",
    };
};

pub const CreateGuardrailVersionOutput = struct {
    /// The unique identifier of the guardrail.
    guardrail_id: []const u8,

    /// The number of the version of the guardrail.
    version: []const u8,

    pub const json_field_names = .{
        .guardrail_id = "guardrailId",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGuardrailVersionInput, options: CallOptions) !CreateGuardrailVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGuardrailVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/guardrails/");
    try path_buf.appendSlice(allocator, input.guardrail_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGuardrailVersionOutput {
    const result: CreateGuardrailVersionOutput = try aws.json.parseJsonObject(
        CreateGuardrailVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
