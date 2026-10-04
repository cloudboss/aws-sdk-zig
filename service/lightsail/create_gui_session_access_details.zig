const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Session = @import("session.zig").Session;
const Status = @import("status.zig").Status;

pub const CreateGUISessionAccessDetailsInput = struct {
    /// The resource name.
    resource_name: []const u8,

    pub const json_field_names = .{
        .resource_name = "resourceName",
    };
};

pub const CreateGUISessionAccessDetailsOutput = struct {
    /// The reason the operation failed.
    failure_reason: ?[]const u8 = null,

    /// The percentage of completion for the operation.
    percentage_complete: ?i32 = null,

    /// The resource name.
    resource_name: ?[]const u8 = null,

    /// Returns information about the specified Amazon DCV GUI session.
    sessions: ?[]const Session = null,

    /// The status of the operation.
    status: ?Status = null,

    pub const json_field_names = .{
        .failure_reason = "failureReason",
        .percentage_complete = "percentageComplete",
        .resource_name = "resourceName",
        .sessions = "sessions",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGUISessionAccessDetailsInput, options: CallOptions) !CreateGUISessionAccessDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGUISessionAccessDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateGUISessionAccessDetails");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGUISessionAccessDetailsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateGUISessionAccessDetailsOutput, body, allocator);
}
