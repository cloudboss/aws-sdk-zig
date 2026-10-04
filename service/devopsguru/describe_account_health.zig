const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeAccountHealthInput = struct {
};

pub const DescribeAccountHealthOutput = struct {
    /// Number of resources that DevOps Guru is monitoring in your Amazon Web
    /// Services account.
    analyzed_resource_count: ?i64 = null,

    /// An integer that specifies the number of metrics that have been analyzed in
    /// your Amazon Web Services
    /// account.
    metrics_analyzed: ?i32 = null,

    /// An integer that specifies the number of open proactive insights in your
    /// Amazon Web Services
    /// account.
    open_proactive_insights: ?i32 = null,

    /// An integer that specifies the number of open reactive insights in your
    /// Amazon Web Services account.
    open_reactive_insights: ?i32 = null,

    /// The number of Amazon DevOps Guru resource analysis hours billed to the
    /// current Amazon Web Services account in
    /// the last hour.
    resource_hours: i64,

    pub const json_field_names = .{
        .analyzed_resource_count = "AnalyzedResourceCount",
        .metrics_analyzed = "MetricsAnalyzed",
        .open_proactive_insights = "OpenProactiveInsights",
        .open_reactive_insights = "OpenReactiveInsights",
        .resource_hours = "ResourceHours",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAccountHealthInput, options: CallOptions) !DescribeAccountHealthOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devops-guru", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAccountHealthInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/accounts/health";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAccountHealthOutput {
    var result: DescribeAccountHealthOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeAccountHealthOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
