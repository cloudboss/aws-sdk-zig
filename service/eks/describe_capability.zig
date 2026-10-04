const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Capability = @import("capability.zig").Capability;

pub const DescribeCapabilityInput = struct {
    /// The name of the capability to describe.
    capability_name: []const u8,

    /// The name of the Amazon EKS cluster that contains the capability you want to
    /// describe.
    cluster_name: []const u8,

    pub const json_field_names = .{
        .capability_name = "capabilityName",
        .cluster_name = "clusterName",
    };
};

pub const DescribeCapabilityOutput = struct {
    /// An object containing detailed information about the capability, including
    /// its name, ARN, type, status, version, configuration, health status, and
    /// timestamps for when it was created and last modified.
    capability: ?Capability = null,

    pub const json_field_names = .{
        .capability = "capability",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCapabilityInput, options: CallOptions) !DescribeCapabilityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCapabilityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/capabilities/");
    try path_buf.appendSlice(allocator, input.capability_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCapabilityOutput {
    const result: DescribeCapabilityOutput = try aws.json.parseJsonObject(
        DescribeCapabilityOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
