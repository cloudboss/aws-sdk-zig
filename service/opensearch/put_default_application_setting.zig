const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutDefaultApplicationSettingInput = struct {
    application_arn: []const u8,

    /// Set to true to set the specified ARN as the default application. Set to
    /// false to clear
    /// the default application.
    set_as_default: bool,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .set_as_default = "setAsDefault",
    };
};

pub const PutDefaultApplicationSettingOutput = struct {
    application_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDefaultApplicationSettingInput, options: CallOptions) !PutDefaultApplicationSettingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDefaultApplicationSettingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/defaultApplicationSetting";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"applicationArn\":");
    try aws.json.writeValue(@TypeOf(input.application_arn), input.application_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"setAsDefault\":");
    try aws.json.writeValue(@TypeOf(input.set_as_default), input.set_as_default, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDefaultApplicationSettingOutput {
    var result: PutDefaultApplicationSettingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutDefaultApplicationSettingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
