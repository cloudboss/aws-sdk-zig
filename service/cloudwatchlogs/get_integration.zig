const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntegrationDetails = @import("integration_details.zig").IntegrationDetails;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;
const IntegrationType = @import("integration_type.zig").IntegrationType;

pub const GetIntegrationInput = struct {
    /// The name of the integration that you want to find information about. To find
    /// the name of
    /// your integration, use
    /// [ListIntegrations](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_ListIntegrations.html)
    integration_name: []const u8,

    pub const json_field_names = .{
        .integration_name = "integrationName",
    };
};

pub const GetIntegrationOutput = struct {
    /// A structure that contains information about the integration configuration.
    /// For an
    /// integration with OpenSearch Service, this includes information about
    /// OpenSearch Service
    /// resources such as the collection, the workspace, and policies.
    integration_details: ?IntegrationDetails = null,

    /// The name of the integration.
    integration_name: ?[]const u8 = null,

    /// The current status of this integration.
    integration_status: ?IntegrationStatus = null,

    /// The type of integration. Integrations with OpenSearch Service have the type
    /// `OPENSEARCH`.
    integration_type: ?IntegrationType = null,

    pub const json_field_names = .{
        .integration_details = "integrationDetails",
        .integration_name = "integrationName",
        .integration_status = "integrationStatus",
        .integration_type = "integrationType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIntegrationInput, options: CallOptions) !GetIntegrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIntegrationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.GetIntegration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIntegrationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetIntegrationOutput, body, allocator);
}
