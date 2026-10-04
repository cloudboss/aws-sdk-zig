const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MaintenanceType = @import("maintenance_type.zig").MaintenanceType;
const MaintenanceStatus = @import("maintenance_status.zig").MaintenanceStatus;

pub const GetDomainMaintenanceStatusInput = struct {
    /// The name of the domain.
    domain_name: []const u8,

    /// The request ID of the maintenance action.
    maintenance_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .maintenance_id = "MaintenanceId",
    };
};

pub const GetDomainMaintenanceStatusOutput = struct {
    /// The action name.
    action: ?MaintenanceType = null,

    /// The time at which the action was created.
    created_at: ?i64 = null,

    /// The node ID of the maintenance action.
    node_id: ?[]const u8 = null,

    /// The status of the maintenance action.
    status: ?MaintenanceStatus = null,

    /// The status message of the maintenance action.
    status_message: ?[]const u8 = null,

    /// The time at which the action was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .action = "Action",
        .created_at = "CreatedAt",
        .node_id = "NodeId",
        .status = "Status",
        .status_message = "StatusMessage",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainMaintenanceStatusInput, options: CallOptions) !GetDomainMaintenanceStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDomainMaintenanceStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/domainMaintenance");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "maintenanceId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.maintenance_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDomainMaintenanceStatusOutput {
    var result: GetDomainMaintenanceStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDomainMaintenanceStatusOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
