const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InsightsRefreshStatus = @import("insights_refresh_status.zig").InsightsRefreshStatus;

pub const StartInsightsRefreshInput = struct {
    /// The name of the cluster for the refresh insights operation.
    cluster_name: []const u8,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
    };
};

pub const StartInsightsRefreshOutput = struct {
    /// The message associated with the insights refresh operation.
    message: ?[]const u8 = null,

    /// The current status of the insights refresh operation.
    status: ?InsightsRefreshStatus = null,

    pub const json_field_names = .{
        .message = "message",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartInsightsRefreshInput, options: CallOptions) !StartInsightsRefreshOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartInsightsRefreshInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/insights-refresh");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartInsightsRefreshOutput {
    var result: StartInsightsRefreshOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartInsightsRefreshOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
