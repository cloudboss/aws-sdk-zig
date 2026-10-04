const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetDesiredCapacityInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// The desired capacity is the initial capacity of the Auto Scaling group after
    /// this operation
    /// completes and the capacity it attempts to maintain.
    desired_capacity: i32,

    /// Indicates whether Amazon EC2 Auto Scaling waits for the cooldown period to
    /// complete before initiating
    /// a scaling activity to set your Auto Scaling group to its new capacity. By
    /// default, Amazon EC2 Auto Scaling does
    /// not honor the cooldown period during manual scaling activities.
    honor_cooldown: ?bool = null,
};

pub const SetDesiredCapacityOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetDesiredCapacityInput, options: CallOptions) !SetDesiredCapacityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetDesiredCapacityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetDesiredCapacity&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    try body_buf.appendSlice(allocator, "&DesiredCapacity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.desired_capacity}) catch "");
    if (input.honor_cooldown) |v| {
        try body_buf.appendSlice(allocator, "&HonorCooldown=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetDesiredCapacityOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetDesiredCapacityOutput = .{};

    return result;
}
