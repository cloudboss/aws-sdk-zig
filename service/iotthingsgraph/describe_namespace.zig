const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeNamespaceInput = struct {
    /// The name of the user's namespace. Set this to `aws` to get the public
    /// namespace.
    namespace_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .namespace_name = "namespaceName",
    };
};

pub const DescribeNamespaceOutput = struct {
    /// The ARN of the namespace.
    namespace_arn: ?[]const u8 = null,

    /// The name of the namespace.
    namespace_name: ?[]const u8 = null,

    /// The version of the user's namespace to describe.
    namespace_version: ?i64 = null,

    /// The name of the public namespace that the latest namespace version is
    /// tracking.
    tracking_namespace_name: ?[]const u8 = null,

    /// The version of the public namespace that the latest version is tracking.
    tracking_namespace_version: ?i64 = null,

    pub const json_field_names = .{
        .namespace_arn = "namespaceArn",
        .namespace_name = "namespaceName",
        .namespace_version = "namespaceVersion",
        .tracking_namespace_name = "trackingNamespaceName",
        .tracking_namespace_version = "trackingNamespaceVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeNamespaceInput, options: CallOptions) !DescribeNamespaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotthingsgraph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotthingsgraph", "IoTThingsGraph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "IotThingsGraphFrontEndService.DescribeNamespace");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeNamespaceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeNamespaceOutput, body, allocator);
}
