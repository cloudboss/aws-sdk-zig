const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const DisableMetricsCollectionInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// Identifies the metrics to disable.
    ///
    /// You can specify one or more of the following metrics:
    ///
    /// * `GroupMinSize`
    ///
    /// * `GroupMaxSize`
    ///
    /// * `GroupDesiredCapacity`
    ///
    /// * `GroupInServiceInstances`
    ///
    /// * `GroupPendingInstances`
    ///
    /// * `GroupStandbyInstances`
    ///
    /// * `GroupTerminatingInstances`
    ///
    /// * `GroupTotalInstances`
    ///
    /// * `GroupInServiceCapacity`
    ///
    /// * `GroupPendingCapacity`
    ///
    /// * `GroupStandbyCapacity`
    ///
    /// * `GroupTerminatingCapacity`
    ///
    /// * `GroupTotalCapacity`
    ///
    /// * `WarmPoolDesiredCapacity`
    ///
    /// * `WarmPoolWarmedCapacity`
    ///
    /// * `WarmPoolPendingCapacity`
    ///
    /// * `WarmPoolTerminatingCapacity`
    ///
    /// * `WarmPoolTotalCapacity`
    ///
    /// * `GroupAndWarmPoolDesiredCapacity`
    ///
    /// * `GroupAndWarmPoolTotalCapacity`
    ///
    /// If you omit this property, all metrics are disabled.
    ///
    /// For more information, see [Amazon CloudWatch metrics for
    /// Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-metrics.html) in the *Amazon EC2 Auto Scaling User Guide*.
    metrics: ?[]const []const u8 = null,
};

pub const DisableMetricsCollectionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisableMetricsCollectionInput, options: CallOptions) !DisableMetricsCollectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "autoscaling", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisableMetricsCollectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DisableMetricsCollection&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    if (input.metrics) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisableMetricsCollectionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: DisableMetricsCollectionOutput = .{};

    return result;
}
