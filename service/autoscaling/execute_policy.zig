const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExecutePolicyInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: ?[]const u8 = null,

    /// The breach threshold for the alarm.
    ///
    /// Required if the policy type is `StepScaling` and not supported
    /// otherwise.
    breach_threshold: ?f64 = null,

    /// Indicates whether Amazon EC2 Auto Scaling waits for the cooldown period to
    /// complete before executing
    /// the policy.
    ///
    /// Valid only if the policy type is `SimpleScaling`. For more information, see
    /// [Scaling
    /// cooldowns for Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-scaling-cooldowns.html) in the *Amazon EC2 Auto Scaling User Guide*.
    honor_cooldown: ?bool = null,

    /// The metric value to compare to `BreachThreshold`. This enables you to
    /// execute a policy of type `StepScaling` and determine which step adjustment
    /// to
    /// use. For example, if the breach threshold is 50 and you want to use a step
    /// adjustment
    /// with a lower bound of 0 and an upper bound of 10, you can set the metric
    /// value to
    /// 59.
    ///
    /// If you specify a metric value that doesn't correspond to a step adjustment
    /// for the
    /// policy, the call returns an error.
    ///
    /// Required if the policy type is `StepScaling` and not supported
    /// otherwise.
    metric_value: ?f64 = null,

    /// The name or ARN of the policy.
    policy_name: []const u8,
};

pub const ExecutePolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecutePolicyInput, options: CallOptions) !ExecutePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecutePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ExecutePolicy&Version=2011-01-01");
    if (input.auto_scaling_group_name) |v| {
        try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.breach_threshold) |v| {
        try body_buf.appendSlice(allocator, "&BreachThreshold=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.honor_cooldown) |v| {
        try body_buf.appendSlice(allocator, "&HonorCooldown=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.metric_value) |v| {
        try body_buf.appendSlice(allocator, "&MetricValue=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&PolicyName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecutePolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: ExecutePolicyOutput = .{};

    return result;
}
