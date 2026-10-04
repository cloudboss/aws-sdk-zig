const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScopeConfiguration = @import("scope_configuration.zig").ScopeConfiguration;
const Tag = @import("tag.zig").Tag;

pub const PutThirdPartyServiceLinkedConfigurationRecorderInput = struct {
    /// The Amazon Resource Name (ARN) of the connector that specifies the
    /// connection between the third-party cloud service provider and Config. The
    /// specified connector must exist.
    connector_arn: []const u8,

    /// Specifies the scope of resources to record from the third-party cloud
    /// service provider.
    scope_configuration: ScopeConfiguration,

    /// The service principal of the Amazon Web Services service for the
    /// service-linked configuration recorder that you want to create.
    service_principal: []const u8,

    /// The tags for a service-linked configuration recorder. Each tag consists of a
    /// key and an optional value, both of which you define.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
        .scope_configuration = "ScopeConfiguration",
        .service_principal = "ServicePrincipal",
        .tags = "Tags",
    };
};

pub const PutThirdPartyServiceLinkedConfigurationRecorderOutput = struct {
    /// The Amazon Resource Name (ARN) of the specified configuration recorder.
    arn: []const u8,

    /// The name of the specified configuration recorder.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutThirdPartyServiceLinkedConfigurationRecorderInput, options: CallOptions) !PutThirdPartyServiceLinkedConfigurationRecorderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutThirdPartyServiceLinkedConfigurationRecorderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.PutThirdPartyServiceLinkedConfigurationRecorder");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutThirdPartyServiceLinkedConfigurationRecorderOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PutThirdPartyServiceLinkedConfigurationRecorderOutput, body, allocator);
}
