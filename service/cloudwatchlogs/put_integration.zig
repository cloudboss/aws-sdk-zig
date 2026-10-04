const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntegrationType = @import("integration_type.zig").IntegrationType;
const ResourceConfig = @import("resource_config.zig").ResourceConfig;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;

pub const PutIntegrationInput = struct {
    /// A name for the integration.
    integration_name: []const u8,

    /// The type of integration. Currently, the only supported type is
    /// `OPENSEARCH`.
    integration_type: IntegrationType,

    /// A structure that contains configuration information for the integration that
    /// you are
    /// creating.
    resource_config: ResourceConfig,

    pub const json_field_names = .{
        .integration_name = "integrationName",
        .integration_type = "integrationType",
        .resource_config = "resourceConfig",
    };
};

pub const PutIntegrationOutput = struct {
    /// The name of the integration that you just created.
    integration_name: ?[]const u8 = null,

    /// The status of the integration that you just created.
    ///
    /// After you create an integration, it takes a few minutes to complete. During
    /// this time,
    /// you'll see the status as `PROVISIONING`.
    integration_status: ?IntegrationStatus = null,

    pub const json_field_names = .{
        .integration_name = "integrationName",
        .integration_status = "integrationStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutIntegrationInput, options: CallOptions) !PutIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutIntegration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutIntegrationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutIntegrationOutput, body, allocator);
}
