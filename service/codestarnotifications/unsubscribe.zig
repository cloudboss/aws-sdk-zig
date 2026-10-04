const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UnsubscribeInput = struct {
    /// The Amazon Resource Name (ARN) of the notification rule.
    arn: []const u8,

    /// The ARN of the Amazon Q Developer in chat applications topic to unsubscribe
    /// from the notification rule.
    target_address: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .target_address = "TargetAddress",
    };
};

pub const UnsubscribeOutput = struct {
    /// The Amazon Resource Name (ARN) of the the notification rule from which you
    /// have removed a subscription.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UnsubscribeInput, options: CallOptions) !UnsubscribeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codestar-notifications", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UnsubscribeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codestar-notifications", "codestar notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/unsubscribe";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TargetAddress\":");
    try aws.json.writeValue(@TypeOf(input.target_address), input.target_address, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UnsubscribeOutput {
    var result: UnsubscribeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UnsubscribeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
