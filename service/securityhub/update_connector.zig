const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CspmProviderUpdateConfiguration = @import("cspm_provider_update_configuration.zig").CspmProviderUpdateConfiguration;
const CspmConnectorStatus = @import("cspm_connector_status.zig").CspmConnectorStatus;
const CspmEnablementStatus = @import("cspm_enablement_status.zig").CspmEnablementStatus;

pub const UpdateConnectorInput = struct {
    /// The unique identifier of the connector to update.
    connector_id: []const u8,

    /// The updated description of the connector.
    description: ?[]const u8 = null,

    /// The updated cloud provider configuration for the connector.
    provider: ?CspmProviderUpdateConfiguration = null,

    pub const json_field_names = .{
        .connector_id = "ConnectorId",
        .description = "Description",
        .provider = "Provider",
    };
};

pub const UpdateConnectorOutput = struct {
    /// The connectivity status of the connector after the update.
    connector_status: ?CspmConnectorStatus = null,

    /// The enablement status of the connector after the update.
    enablement_status: ?CspmEnablementStatus = null,

    pub const json_field_names = .{
        .connector_status = "ConnectorStatus",
        .enablement_status = "EnablementStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConnectorInput, options: CallOptions) !UpdateConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/connectors/");
    try path_buf.appendSlice(allocator, input.connector_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.provider) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Provider\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConnectorOutput {
    const result: UpdateConnectorOutput = try aws.json.parseJsonObject(
        UpdateConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
