const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CspmEnablementStatus = @import("cspm_enablement_status.zig").CspmEnablementStatus;
const CspmHealthCheck = @import("cspm_health_check.zig").CspmHealthCheck;
const CspmProviderDetail = @import("cspm_provider_detail.zig").CspmProviderDetail;

pub const GetConnectorInput = struct {
    /// The unique identifier of the connector to retrieve.
    connector_id: []const u8,

    pub const json_field_names = .{
        .connector_id = "ConnectorId",
    };
};

pub const GetConnectorOutput = struct {
    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: ?[]const u8 = null,

    /// The unique identifier of the connector.
    connector_id: []const u8,

    /// The ISO 8601 UTC timestamp indicating when the connector was created.
    created_at: i64,

    /// The service principal that created the connector.
    created_by: ?[]const u8 = null,

    /// The description of the connector.
    description: ?[]const u8 = null,

    /// The enablement status of the connector.
    enablement_status: ?CspmEnablementStatus = null,

    /// The health status of the connector, including connectivity status and last
    /// check time.
    health: ?CspmHealthCheck = null,

    /// The ISO 8601 UTC timestamp indicating when the connector was last updated.
    last_updated_at: i64,

    /// The name of the connector.
    name: []const u8,

    /// The cloud provider configuration details for the connector.
    provider_detail: ?CspmProviderDetail = null,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
        .connector_id = "ConnectorId",
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .description = "Description",
        .enablement_status = "EnablementStatus",
        .health = "Health",
        .last_updated_at = "LastUpdatedAt",
        .name = "Name",
        .provider_detail = "ProviderDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConnectorInput, options: CallOptions) !GetConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/connectors/");
    try path_buf.appendSlice(allocator, input.connector_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConnectorOutput {
    const result: GetConnectorOutput = try aws.json.parseJsonObject(
        GetConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
