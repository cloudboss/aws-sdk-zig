const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SendOTPMessageRequestParameters = @import("send_otp_message_request_parameters.zig").SendOTPMessageRequestParameters;
const MessageResponse = @import("message_response.zig").MessageResponse;

pub const SendOTPMessageInput = struct {
    /// The unique ID of your Amazon Pinpoint application.
    application_id: []const u8,

    send_otp_message_request_parameters: SendOTPMessageRequestParameters,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .send_otp_message_request_parameters = "SendOTPMessageRequestParameters",
    };
};

pub const SendOTPMessageOutput = struct {
    message_response: ?MessageResponse = null,

    pub const json_field_names = .{
        .message_response = "MessageResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendOTPMessageInput, options: CallOptions) !SendOTPMessageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mobiletargeting", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendOTPMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpoint", "Pinpoint", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apps/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/otp");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = try aws.json.jsonStringify(input.send_otp_message_request_parameters, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendOTPMessageOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: SendOTPMessageOutput = .{};

    return result;
}
