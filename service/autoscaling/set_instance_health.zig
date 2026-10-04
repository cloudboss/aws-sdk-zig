const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetInstanceHealthInput = struct {
    /// The health status of the instance. Set to `Healthy` to have the instance
    /// remain in service. Set to `Unhealthy` to have the instance be out of
    /// service.
    /// Amazon EC2 Auto Scaling terminates and replaces the unhealthy instance.
    health_status: []const u8,

    /// The ID of the instance.
    instance_id: []const u8,

    /// If the Auto Scaling group of the specified instance has a
    /// `HealthCheckGracePeriod`
    /// specified for the group, by default, this call respects the grace period.
    /// Set this to
    /// `False`, to have the call not respect the grace period associated with
    /// the group.
    ///
    /// For more information about the health check grace period, see [Set the
    /// health check grace period for an Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/health-check-grace-period.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    should_respect_grace_period: ?bool = null,
};

pub const SetInstanceHealthOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetInstanceHealthInput, options: CallOptions) !SetInstanceHealthOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetInstanceHealthInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetInstanceHealth&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&HealthStatus=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.health_status);
    try body_buf.appendSlice(allocator, "&InstanceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.instance_id);
    if (input.should_respect_grace_period) |v| {
        try body_buf.appendSlice(allocator, "&ShouldRespectGracePeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetInstanceHealthOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetInstanceHealthOutput = .{};

    return result;
}
