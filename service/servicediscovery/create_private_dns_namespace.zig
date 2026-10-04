const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrivateDnsNamespaceProperties = @import("private_dns_namespace_properties.zig").PrivateDnsNamespaceProperties;
const Tag = @import("tag.zig").Tag;

pub const CreatePrivateDnsNamespaceInput = struct {
    /// A unique string that identifies the request and that allows failed
    /// `CreatePrivateDnsNamespace` requests to be retried without the risk of
    /// running the
    /// operation twice. `CreatorRequestId` can be any unique string (for example, a
    /// date/timestamp).
    creator_request_id: ?[]const u8 = null,

    /// A description for the namespace.
    description: ?[]const u8 = null,

    /// The name that you want to assign to this namespace. When you create a
    /// private DNS namespace,
    /// Cloud Map automatically creates an Amazon Route 53 private hosted zone that
    /// has the same name as the
    /// namespace.
    name: []const u8,

    /// Properties for the
    /// private DNS namespace.
    properties: ?PrivateDnsNamespaceProperties = null,

    /// The tags to add to the namespace. Each tag consists of a key and an optional
    /// value that you
    /// define. Tags keys can be up to 128 characters in length, and tag values can
    /// be up to 256
    /// characters in length.
    tags: ?[]const Tag = null,

    /// The ID of the Amazon VPC that you want to associate the namespace with.
    vpc: []const u8,

    pub const json_field_names = .{
        .creator_request_id = "CreatorRequestId",
        .description = "Description",
        .name = "Name",
        .properties = "Properties",
        .tags = "Tags",
        .vpc = "Vpc",
    };
};

pub const CreatePrivateDnsNamespaceOutput = struct {
    /// A value that you can use to determine whether the request completed
    /// successfully.
    /// To get the status of the operation, see
    /// [GetOperation](https://docs.aws.amazon.com/cloud-map/latest/api/API_GetOperation.html).
    operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePrivateDnsNamespaceInput, options: CallOptions) !CreatePrivateDnsNamespaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePrivateDnsNamespaceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.CreatePrivateDnsNamespace");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePrivateDnsNamespaceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePrivateDnsNamespaceOutput, body, allocator);
}
