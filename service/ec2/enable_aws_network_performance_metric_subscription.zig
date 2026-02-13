const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MetricType = @import("metric_type.zig").MetricType;
const StatisticType = @import("statistic_type.zig").StatisticType;

/// Enables Infrastructure Performance subscriptions.
pub const EnableAwsNetworkPerformanceMetricSubscriptionInput = struct {
    /// The target Region (like `us-east-2`) or Availability Zone ID (like
    /// `use2-az2`) that the metric subscription is enabled for. If you use
    /// Availability Zone IDs, the Source and Destination Availability Zones must be
    /// in the same Region.
    destination: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The metric used for the enabled subscription.
    metric: ?MetricType = null,

    /// The source Region (like `us-east-1`) or Availability Zone ID (like
    /// `use1-az1`) that the metric subscription is enabled for. If you use
    /// Availability Zone IDs, the Source and Destination Availability Zones must be
    /// in the same Region.
    source: ?[]const u8 = null,

    /// The statistic used for the enabled subscription.
    statistic: ?StatisticType = null,
};

pub const EnableAwsNetworkPerformanceMetricSubscriptionOutput = struct {
    /// Indicates whether the subscribe action was successful.
    output: ?bool = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *EnableAwsNetworkPerformanceMetricSubscriptionOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: EnableAwsNetworkPerformanceMetricSubscriptionInput, options: Options) !EnableAwsNetworkPerformanceMetricSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: EnableAwsNetworkPerformanceMetricSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=EnableAwsNetworkPerformanceMetricSubscription&Version=2016-11-15");
    if (input.destination) |v| {
        try body_buf.appendSlice(alloc, "&Destination=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.metric) |v| {
        try body_buf.appendSlice(alloc, "&Metric=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.source) |v| {
        try body_buf.appendSlice(alloc, "&Source=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.statistic) |v| {
        try body_buf.appendSlice(alloc, "&Statistic=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !EnableAwsNetworkPerformanceMetricSubscriptionOutput {
    _ = status;
    _ = headers;
    _ = alloc;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: EnableAwsNetworkPerformanceMetricSubscriptionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "output")) {
                    result.output = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
