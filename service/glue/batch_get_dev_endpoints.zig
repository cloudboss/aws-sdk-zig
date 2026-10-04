const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DevEndpoint = @import("dev_endpoint.zig").DevEndpoint;

pub const BatchGetDevEndpointsInput = struct {
    /// The list of `DevEndpoint` names, which might be the names returned from the
    /// `ListDevEndpoint` operation.
    dev_endpoint_names: []const []const u8,

    pub const json_field_names = .{
        .dev_endpoint_names = "DevEndpointNames",
    };
};

pub const BatchGetDevEndpointsOutput = struct {
    /// A list of `DevEndpoint` definitions.
    dev_endpoints: ?[]const DevEndpoint = null,

    /// A list of `DevEndpoints` not found.
    dev_endpoints_not_found: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .dev_endpoints = "DevEndpoints",
        .dev_endpoints_not_found = "DevEndpointsNotFound",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetDevEndpointsInput, options: CallOptions) !BatchGetDevEndpointsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetDevEndpointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.BatchGetDevEndpoints");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetDevEndpointsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetDevEndpointsOutput, body, allocator);
}
