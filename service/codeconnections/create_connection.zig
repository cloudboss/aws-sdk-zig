const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProviderType = @import("provider_type.zig").ProviderType;
const Tag = @import("tag.zig").Tag;

pub const CreateConnectionInput = struct {
    /// The name of the connection to be created.
    connection_name: []const u8,

    /// The Amazon Resource Name (ARN) of the host associated with the connection to
    /// be created.
    host_arn: ?[]const u8 = null,

    /// The name of the external provider where your third-party code repository is
    /// configured.
    provider_type: ?ProviderType = null,

    /// The key-value pair to use when tagging the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .host_arn = "HostArn",
        .provider_type = "ProviderType",
        .tags = "Tags",
    };
};

pub const CreateConnectionOutput = struct {
    /// The Amazon Resource Name (ARN) of the connection to be created. The ARN is
    /// used as the
    /// connection reference when the connection is shared between Amazon Web
    /// Services services.
    ///
    /// The ARN is never reused if the connection is deleted.
    connection_arn: []const u8,

    /// Specifies the tags applied to the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectionInput, options: CallOptions) !CreateConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeconnections", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("codeconnections", "CodeConnections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeConnections_20231201.CreateConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateConnectionOutput, body, allocator);
}
