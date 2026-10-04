const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnablementStatus = @import("enablement_status.zig").EnablementStatus;
const HealthCheck = @import("health_check.zig").HealthCheck;
const ProviderDetail = @import("provider_detail.zig").ProviderDetail;

pub const GetConnectorV2Input = struct {
    /// The UUID of the connectorV2 to identify connectorV2 resource.
    connector_id: []const u8,

    pub const json_field_names = .{
        .connector_id = "ConnectorId",
    };
};

pub const GetConnectorV2Output = struct {
    /// The Amazon Resource Name (ARN) of the connectorV2.
    connector_arn: ?[]const u8 = null,

    /// The UUID of the connectorV2 to identify connectorV2 resource.
    connector_id: []const u8,

    /// ISO 8601 UTC timestamp for the time create the connectorV2.
    created_at: i64,

    /// The description of the connectorV2.
    description: ?[]const u8 = null,

    /// The enablement status of the connector.
    enablement_status: ?EnablementStatus = null,

    /// The reason for the current enablement status. Provides additional context
    /// when the connector is in a failed state.
    enablement_status_reason: ?[]const u8 = null,

    /// The current health status for connectorV2
    health: ?HealthCheck = null,

    /// The Amazon Resource Name (ARN) of KMS key used for the connectorV2.
    kms_key_arn: ?[]const u8 = null,

    /// ISO 8601 UTC timestamp for the time update the connectorV2 connectorStatus.
    last_updated_at: i64,

    /// The name of the connectorV2.
    name: []const u8,

    /// The third-party provider detail for a service configuration.
    provider_detail: ?ProviderDetail = null,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
        .connector_id = "ConnectorId",
        .created_at = "CreatedAt",
        .description = "Description",
        .enablement_status = "EnablementStatus",
        .enablement_status_reason = "EnablementStatusReason",
        .health = "Health",
        .kms_key_arn = "KmsKeyArn",
        .last_updated_at = "LastUpdatedAt",
        .name = "Name",
        .provider_detail = "ProviderDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConnectorV2Input, options: CallOptions) !GetConnectorV2Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConnectorV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/connectorsv2/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConnectorV2Output {
    const result: GetConnectorV2Output = try aws.json.parseJsonObject(
        GetConnectorV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
