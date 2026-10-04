const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Route = @import("route.zig").Route;
const Status = @import("status.zig").Status;

pub const GetMultiRegionEndpointInput = struct {
    /// The name of the multi-region endpoint (global-endpoint).
    endpoint_name: []const u8,

    pub const json_field_names = .{
        .endpoint_name = "EndpointName",
    };
};

pub const GetMultiRegionEndpointOutput = struct {
    /// The time stamp of when the multi-region endpoint (global-endpoint) was
    /// created.
    created_timestamp: ?i64 = null,

    /// The ID of the multi-region endpoint (global-endpoint).
    endpoint_id: ?[]const u8 = null,

    /// The name of the multi-region endpoint (global-endpoint).
    endpoint_name: ?[]const u8 = null,

    /// The time stamp of when the multi-region endpoint (global-endpoint) was last
    /// updated.
    last_updated_timestamp: ?i64 = null,

    /// Contains routes information for the multi-region endpoint (global-endpoint).
    routes: ?[]const Route = null,

    /// The status of the multi-region endpoint (global-endpoint).
    ///
    /// * `CREATING` – The resource is being provisioned.
    ///
    /// * `READY` – The resource is ready to use.
    ///
    /// * `FAILED` – The resource failed to be provisioned.
    ///
    /// * `DELETING` – The resource is being deleted as requested.
    status: ?Status = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .endpoint_id = "EndpointId",
        .endpoint_name = "EndpointName",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .routes = "Routes",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMultiRegionEndpointInput, options: CallOptions) !GetMultiRegionEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMultiRegionEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/multi-region-endpoints/");
    try path_buf.appendSlice(allocator, input.endpoint_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMultiRegionEndpointOutput {
    const result: GetMultiRegionEndpointOutput = try aws.json.parseJsonObject(
        GetMultiRegionEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
