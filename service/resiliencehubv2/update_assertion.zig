const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Assertion = @import("assertion.zig").Assertion;

pub const UpdateAssertionInput = struct {
    /// The unique identifier of the assertion to update.
    assertion_id: []const u8,

    service_arn: []const u8,

    /// The updated text content of the assertion.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .assertion_id = "assertionId",
        .service_arn = "serviceArn",
        .text = "text",
    };
};

pub const UpdateAssertionOutput = struct {
    /// The updated assertion.
    assertion: ?Assertion = null,

    pub const json_field_names = .{
        .assertion = "assertion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssertionInput, options: CallOptions) !UpdateAssertionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssertionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehubv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/update-assertion";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"assertionId\":");
    try aws.json.writeValue(@TypeOf(input.assertion_id), input.assertion_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceArn\":");
    try aws.json.writeValue(@TypeOf(input.service_arn), input.service_arn, allocator, &body_buf);
    has_prev = true;
    if (input.text) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"text\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssertionOutput {
    const result: UpdateAssertionOutput = try aws.json.parseJsonObject(
        UpdateAssertionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
