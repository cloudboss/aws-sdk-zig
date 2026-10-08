const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceReusePolicy = @import("instance_reuse_policy.zig").InstanceReusePolicy;
const WarmPoolState = @import("warm_pool_state.zig").WarmPoolState;
const serde = @import("serde.zig");

pub const PutWarmPoolInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// Indicates whether instances in the Auto Scaling group can be returned to the
    /// warm pool on
    /// scale in. The default is to terminate instances in the Auto Scaling group
    /// when the group scales
    /// in.
    instance_reuse_policy: ?InstanceReusePolicy = null,

    /// Specifies the maximum number of instances that are allowed to be in the warm
    /// pool or
    /// in any state except `Terminated` for the Auto Scaling group. This is an
    /// optional
    /// property. Specify it only if you do not want the warm pool size to be
    /// determined by the
    /// difference between the group's maximum capacity and its desired capacity.
    ///
    /// If a value for `MaxGroupPreparedCapacity` is not specified, Amazon EC2 Auto
    /// Scaling
    /// launches and maintains the difference between the group's maximum capacity
    /// and its
    /// desired capacity. If you specify a value for `MaxGroupPreparedCapacity`,
    /// Amazon EC2 Auto Scaling uses the difference between the
    /// `MaxGroupPreparedCapacity` and
    /// the desired capacity instead.
    ///
    /// The size of the warm pool is dynamic. Only when
    /// `MaxGroupPreparedCapacity` and `MinSize` are set to the
    /// same value does the warm pool have an absolute size.
    ///
    /// If the desired capacity of the Auto Scaling group is higher than the
    /// `MaxGroupPreparedCapacity`, the capacity of the warm pool is 0, unless
    /// you specify a value for `MinSize`. To remove a value that you previously
    /// set,
    /// include the property but specify -1 for the value.
    max_group_prepared_capacity: ?i32 = null,

    /// Specifies the minimum number of instances to maintain in the warm pool. This
    /// helps you
    /// to ensure that there is always a certain number of warmed instances
    /// available to handle
    /// traffic spikes. Defaults to 0 if not specified.
    min_size: ?i32 = null,

    /// Sets the instance state to transition to after the lifecycle actions are
    /// complete.
    /// Default is `Stopped`.
    pool_state: ?WarmPoolState = null,
};

pub const PutWarmPoolOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutWarmPoolInput, options: CallOptions) !PutWarmPoolOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutWarmPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PutWarmPool&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    if (input.instance_reuse_policy) |v| {
        if (v.reuse_on_scale_in) |sv| {
            try body_buf.appendSlice(allocator, "&InstanceReusePolicy.ReuseOnScaleIn=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.max_group_prepared_capacity) |v| {
        try body_buf.appendSlice(allocator, "&MaxGroupPreparedCapacity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.min_size) |v| {
        try body_buf.appendSlice(allocator, "&MinSize=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.pool_state) |v| {
        try body_buf.appendSlice(allocator, "&PoolState=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutWarmPoolOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: PutWarmPoolOutput = .{};

    return result;
}
