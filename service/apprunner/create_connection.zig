const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProviderType = @import("provider_type.zig").ProviderType;
const Tag = @import("tag.zig").Tag;
const Connection = @import("connection.zig").Connection;

pub const CreateConnectionInput = struct {
    /// A name for the new connection. It must be unique across all App Runner
    /// connections for the Amazon Web Services account in the Amazon Web Services
    /// Region.
    connection_name: []const u8,

    /// The source repository provider.
    provider_type: ProviderType,

    /// A list of metadata items that you can associate with your connection
    /// resource. A tag is a key-value pair.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .provider_type = "ProviderType",
        .tags = "Tags",
    };
};

pub const CreateConnectionOutput = struct {
    /// A description of the App Runner connection that's created by this request.
    connection: ?Connection = null,

    pub const json_field_names = .{
        .connection = "Connection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectionInput, options: CallOptions) !CreateConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apprunner", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apprunner", "AppRunner", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AppRunner.CreateConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateConnectionOutput, body, allocator);
}
