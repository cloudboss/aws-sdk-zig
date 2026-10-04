const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrivateDnsNamespaceChange = @import("private_dns_namespace_change.zig").PrivateDnsNamespaceChange;

pub const UpdatePrivateDnsNamespaceInput = struct {
    /// The ID or Amazon Resource Name (ARN) of the namespace that you want to
    /// update.
    id: []const u8,

    /// Updated properties for the private DNS namespace.
    namespace: PrivateDnsNamespaceChange,

    /// A unique string that identifies the request and that allows failed
    /// `UpdatePrivateDnsNamespace` requests to be retried without the risk of
    /// running the
    /// operation twice. `UpdaterRequestId` can be any unique string (for example, a
    /// date/timestamp).
    updater_request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .namespace = "Namespace",
        .updater_request_id = "UpdaterRequestId",
    };
};

pub const UpdatePrivateDnsNamespaceOutput = struct {
    /// A value that you can use to determine whether the request completed
    /// successfully.
    /// To get the status of the operation, see
    /// [GetOperation](https://docs.aws.amazon.com/cloud-map/latest/api/API_GetOperation.html).
    operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePrivateDnsNamespaceInput, options: CallOptions) !UpdatePrivateDnsNamespaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicediscovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePrivateDnsNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicediscovery", "ServiceDiscovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.UpdatePrivateDnsNamespace");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePrivateDnsNamespaceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePrivateDnsNamespaceOutput, body, allocator);
}
