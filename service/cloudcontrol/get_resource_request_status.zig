const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HookProgressEvent = @import("hook_progress_event.zig").HookProgressEvent;
const ProgressEvent = @import("progress_event.zig").ProgressEvent;

pub const GetResourceRequestStatusInput = struct {
    /// A unique token used to track the progress of the resource operation request.
    ///
    /// Request tokens are included in the `ProgressEvent` type returned by a
    /// resource
    /// operation request.
    request_token: []const u8,

    pub const json_field_names = .{
        .request_token = "RequestToken",
    };
};

pub const GetResourceRequestStatusOutput = struct {
    /// Lists Hook invocations for the specified target in the request. This is a
    /// list since the same target can invoke multiple Hooks.
    hooks_progress_event: ?[]const HookProgressEvent = null,

    /// Represents the current status of the resource operation request.
    progress_event: ?ProgressEvent = null,

    pub const json_field_names = .{
        .hooks_progress_event = "HooksProgressEvent",
        .progress_event = "ProgressEvent",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceRequestStatusInput, options: CallOptions) !GetResourceRequestStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudapiservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceRequestStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudcontrolapi", "CloudControl", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CloudApiService.GetResourceRequestStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceRequestStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetResourceRequestStatusOutput, body, allocator);
}
