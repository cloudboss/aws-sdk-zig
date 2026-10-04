const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;
const IntegrationType = @import("integration_type.zig").IntegrationType;
const IntegrationSummary = @import("integration_summary.zig").IntegrationSummary;

pub const ListIntegrationsInput = struct {
    /// To limit the results to integrations that start with a certain name prefix,
    /// specify that
    /// name prefix here.
    integration_name_prefix: ?[]const u8 = null,

    /// To limit the results to integrations with a certain status, specify that
    /// status
    /// here.
    integration_status: ?IntegrationStatus = null,

    /// To limit the results to integrations of a certain type, specify that type
    /// here.
    integration_type: ?IntegrationType = null,

    pub const json_field_names = .{
        .integration_name_prefix = "integrationNamePrefix",
        .integration_status = "integrationStatus",
        .integration_type = "integrationType",
    };
};

pub const ListIntegrationsOutput = struct {
    /// An array, where each object in the array contains information about one
    /// CloudWatch Logs
    /// integration in this account.
    integration_summaries: ?[]const IntegrationSummary = null,

    pub const json_field_names = .{
        .integration_summaries = "integrationSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIntegrationsInput, options: CallOptions) !ListIntegrationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIntegrationsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.ListIntegrations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIntegrationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListIntegrationsOutput, body, allocator);
}
