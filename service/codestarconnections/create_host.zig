const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProviderType = @import("provider_type.zig").ProviderType;
const Tag = @import("tag.zig").Tag;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

pub const CreateHostInput = struct {
    /// The name of the host to be created.
    name: []const u8,

    /// The endpoint of the infrastructure to be represented by the host after it is
    /// created.
    provider_endpoint: []const u8,

    /// The name of the installed provider to be associated with your connection.
    /// The host
    /// resource represents the infrastructure where your provider type is
    /// installed. The valid
    /// provider type is GitHub Enterprise Server.
    provider_type: ProviderType,

    /// Tags for the host to be created.
    tags: ?[]const Tag = null,

    /// The VPC configuration to be provisioned for the host. A VPC must be
    /// configured and the
    /// infrastructure to be represented by the host must already be connected to
    /// the VPC.
    vpc_configuration: ?VpcConfiguration = null,

    pub const json_field_names = .{
        .name = "Name",
        .provider_endpoint = "ProviderEndpoint",
        .provider_type = "ProviderType",
        .tags = "Tags",
        .vpc_configuration = "VpcConfiguration",
    };
};

pub const CreateHostOutput = struct {
    /// The Amazon Resource Name (ARN) of the host to be created.
    host_arn: ?[]const u8 = null,

    /// Tags for the created host.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .host_arn = "HostArn",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHostInput, options: CallOptions) !CreateHostOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codestar-connections", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHostInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codestar-connections", "CodeStar connections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeStar_connections_20191201.CreateHost");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHostOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateHostOutput, body, allocator);
}
