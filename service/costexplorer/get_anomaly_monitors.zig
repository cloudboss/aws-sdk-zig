const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnomalyMonitor = @import("anomaly_monitor.zig").AnomalyMonitor;

pub const GetAnomalyMonitorsInput = struct {
    /// The number of entries that a paginated response contains.
    max_results: ?i32 = null,

    /// A list of cost anomaly monitor ARNs.
    monitor_arn_list: ?[]const []const u8 = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when
    /// the response from a previous call has more results than the maximum page
    /// size.
    next_page_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .monitor_arn_list = "MonitorArnList",
        .next_page_token = "NextPageToken",
    };
};

pub const GetAnomalyMonitorsOutput = struct {
    /// A list of cost anomaly monitors that includes the detailed metadata for each
    /// monitor.
    anomaly_monitors: ?[]const AnomalyMonitor = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when
    /// the response from a previous call has more results than the maximum page
    /// size.
    next_page_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .anomaly_monitors = "AnomalyMonitors",
        .next_page_token = "NextPageToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAnomalyMonitorsInput, options: CallOptions) !GetAnomalyMonitorsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAnomalyMonitorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetAnomalyMonitors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAnomalyMonitorsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAnomalyMonitorsOutput, body, allocator);
}
