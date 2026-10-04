const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;

pub const GetResourceDashboardInput = struct {
    /// The ID of the application that the resource belongs to.
    application_id: []const u8,

    /// The ID of the resource.
    resource_id: []const u8,

    /// The type of resource to access the dashboard for. Currently, only `Session`
    /// is supported.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

pub const GetResourceDashboardOutput = struct {
    /// A URL to the resource dashboard. For an active resource, this URL opens the
    /// live application UI. For a terminated resource, this URL opens the
    /// persistent application UI. This value is not included in the response if the
    /// URL is not available.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .url = "url",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceDashboardInput, options: CallOptions) !GetResourceDashboardOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "emr-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceDashboardInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr-serverless", "EMR Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/dashboard");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "resourceId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.resource_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "resourceType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.resource_type.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceDashboardOutput {
    var result: GetResourceDashboardOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetResourceDashboardOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
