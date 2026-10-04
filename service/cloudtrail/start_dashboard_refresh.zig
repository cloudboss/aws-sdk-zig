const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartDashboardRefreshInput = struct {
    /// The name or ARN of the dashboard.
    dashboard_id: []const u8,

    /// The query parameter values for the dashboard
    ///
    /// For custom dashboards, the following query parameters are valid:
    /// `$StartTime$`, `$EndTime$`, and `$Period$`.
    ///
    /// For managed dashboards, the following query parameters are valid:
    /// `$StartTime$`,
    /// `$EndTime$`, `$Period$`, and `$EventDataStoreId$`. The
    /// `$EventDataStoreId$` query parameter is required.
    query_parameter_values: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .dashboard_id = "DashboardId",
        .query_parameter_values = "QueryParameterValues",
    };
};

pub const StartDashboardRefreshOutput = struct {
    /// The refresh ID for the dashboard.
    refresh_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .refresh_id = "RefreshId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDashboardRefreshInput, options: CallOptions) !StartDashboardRefreshOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDashboardRefreshInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.StartDashboardRefresh");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDashboardRefreshOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartDashboardRefreshOutput, body, allocator);
}
